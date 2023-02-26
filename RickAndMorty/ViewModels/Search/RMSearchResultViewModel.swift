//
//  RMSearchResultViewModel.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 2/26/23.
//

import Foundation

enum RMSearchResultViewModel {
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMCharacterEpisodeCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
}
