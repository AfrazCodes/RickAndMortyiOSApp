//
//  RMLocationTableViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 12/28/22.
//

import Foundation

struct RMLocationTableViewCellViewModel: Hashable, Equatable {

    private let location: RMLocation

    init(location: RMLocation) {
        self.location = location
    }

    public var name: String {
        return location.name
    }

    public var type: String {
        return "Type: "+location.type
    }

    public var dimension: String {
        return location.dimension
    }

    static func == (lhs: RMLocationTableViewCellViewModel, rhs: RMLocationTableViewCellViewModel) -> Bool {
        return lhs.location.id == rhs.location.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(location.id)
        hasher.combine(dimension)
        hasher.combine(type)
    }
}
