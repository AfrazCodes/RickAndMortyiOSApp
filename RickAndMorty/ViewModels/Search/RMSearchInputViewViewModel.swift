//
//  RMSearchInputViewViewModel.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 12/28/22.
//

import Foundation

final class RMSearchInputViewViewModel {
    private let type: RMSearchViewController.Config.`Type`

    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"

        var queryArgument: String {
            switch self {
            case .status: return "status"
            case .gender: return "gender"
            case .locationType: return "type"
            }
        }

        var choices: [String] {
            switch self {
            case .status:
                return ["alive", "dead", "unknown"]

            case .gender:
                return ["male", "female", "genderless", "unknown"]

            case .locationType:
                return ["cluster", "planet", "microverse"]
            }
        }
    }

    init(type: RMSearchViewController.Config.`Type`) {
        self.type = type
    }

    // MARK: - Public

    public var hasDynamicOptions: Bool {
        switch self.type {
        case .character, .location:
            return true
        case .episode:
            return false
        }
    }

    public var options: [DynamicOption] {
        switch self.type {
        case .character:
            return [.status, .gender]
        case .location:
            return [.locationType]
        case .episode:
            return []
        }
    }

    public var searchPlaceholderText: String {
        switch self.type {
        case .character:
            return "Character Name"
        case .location:
            return "Location Name"
        case .episode:
            return "Episode Title"
        }
    }
}
