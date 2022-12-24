//
//  RMGetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 12/23/22.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [RMCharacter]
}
