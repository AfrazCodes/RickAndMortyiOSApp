//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 12/23/22.
//

import Foundation

/// Represents unique API endpoint
@frozen enum RMEndpoint: String, CaseIterable, Hashable {
    /// Endpoint to get character info
    case character
    /// Endpoint to get location info
    case location
    /// Endpoint to get episode info
    case episode
}
