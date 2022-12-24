//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 12/24/22.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter

    init(character: RMCharacter) {
        self.character = character
    }

    public var title: String {
        character.name.uppercased()
    }
}
