//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 12/22/22.
//

import Foundation

struct RMEpisode: Codable, RMEpisodeDataRender {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
