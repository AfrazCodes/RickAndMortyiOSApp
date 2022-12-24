//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Afraz Siddiqui on 12/23/22.
//

import Foundation

/// Object that represents a singlet API call
final class RMRequest {
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }

    /// Desired endpoint
    private let endpoint: RMEndpoint

    /// Path components for API, if any
    private let pathComponents: [String]

    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]

    /// Constructed url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue

        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }

        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")

            string += argumentString
        }

        return string
    }

    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }

    /// Desired http method
    public let httpMethod = "GET"

    // MARK: - Public

    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of Path components
    ///   - queryParameters: Collection of query parameters
    public init(
        endpoint: RMEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character)
}
