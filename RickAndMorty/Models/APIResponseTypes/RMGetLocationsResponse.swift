//
//  RMGetLocationsResponse.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 12/28/22.
//

import Foundation

struct RMGetAllLocationsResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [RMLocation]
}
