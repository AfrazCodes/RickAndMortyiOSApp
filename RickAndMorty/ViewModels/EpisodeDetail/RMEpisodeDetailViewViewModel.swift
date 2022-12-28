//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 12/25/22.
//

import UIKit

protocol RMEpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

final class RMEpisodeDetailViewViewModel {
    private let endpointUrl: URL?
    private var dataTuple: (episode: RMEpisode, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetails()
        }
    }

    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }

    public weak var delegate: RMEpisodeDetailViewViewModelDelegate?

    public private(set) var cellViewModels: [SectionType] = []

    // MARK: - Init

    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }

    public func character(at index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else {
            return nil
        }
        return dataTuple.characters[index]
    }

    // MARK: - Private

    private func createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }

        let episode = dataTuple.episode
        let characters = dataTuple.characters

        var createdString = episode.created
        if let date = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: episode.created) {
            createdString = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }

        cellViewModels = [
            .information(viewModels: [
                .init(title: "Episode Name", value: episode.name),
                .init(title: "Air Date", value: episode.air_date),
                .init(title: "Episode", value: episode.episode),
                .init(title: "Created", value: createdString),
            ]),
            .characters(viewModel: characters.compactMap({ character in
                return RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
            }))
        ]
    }

    /// Fetch backing episode model
    public func fetchEpisodeData() {
        guard let url = endpointUrl,
              let request = RMRequest(url: url) else {
            return
        }
        Task {
            let result = await RMService.shared.execute(request, excepting: RMEpisode.self)
            switch result {
            case .success(let episode):
//                self.fetchRelatedCharacters(episode: episode)
                await asyncFetchRelatedCharacters(episode: episode)
            case .failure:
                break
            }
        }
    }

    private func fetchRelatedCharacters(episode: RMEpisode) {
        let requests: [RMRequest] = episode.characters.compactMap({
            return URL(string: $0)
        }).compactMap({
            return RMRequest(url: $0)
        })

        // 10 of parallel requests
        // Notified once all done

        let group = DispatchGroup()
        var characters: [RMCharacter] = []
        for request in requests {
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in
                defer {
                    group.leave()
                }

                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
        }

        group.notify(queue: .main) {
            self.dataTuple = (
                episode: episode,
                characters: characters
            )
        }
    }
    
    private func asyncFetchRelatedCharacters(episode: RMEpisode) async {
        let requests: [RMRequest] = episode.characters.compactMap({
            return URL(string: $0)
        }).compactMap({
            return RMRequest(url: $0)
        })

        let characters = await withTaskGroup(of: RMCharacter?.self, returning: [RMCharacter].self, body: { taskGroup in
            print("Task start   : \(Date())")
            
            var childResult: [RMCharacter] = []
            for request in requests {
                // run chil task
                taskGroup.addTask {
                    let result = await RMService.shared.execute(request, excepting: RMCharacter.self)
                    switch result {
                    case .success(let model):
                        return model
                    case .failure(let error):
                        print("get character occur error: \(error)")
                        return nil
                    }
                }
                // collect the child task result
                for await taskResult in taskGroup {
                    if let result = taskResult {
                        childResult.append(result)
                    }
                }
            }
            return childResult
        })
      
        print("Task end     : \(Date())")
        print("allResults   : \(characters.count)")
        
        await MainActor.run(body: {
            self.dataTuple = (
                episode: episode,
                characters: characters
            )
        })
    }
    
}
