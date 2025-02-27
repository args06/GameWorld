//
//  Endpoint.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation
import Core

public struct Endpoint {
    public let path: String
    public let queryItems: [URLQueryItem]?
    public let searchQuery: String?

    public init(path: String, queryItems: [URLQueryItem]?, searchQuery: String? = nil) {
        self.path = path
        var items = queryItems ?? []
        items
            .append(URLQueryItem(name: "key", value: Configuration.shared.getAPIKey()))
        self.queryItems = items
        self.searchQuery = searchQuery
    }

    public var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.rawg.io"
        components.path = "/api" + path
        components.queryItems = queryItems
        return components.url
    }
}

public extension Endpoint {

    public static func fetchGames(page: Int? = nil, query: String? = nil) -> Endpoint {
        var queryItems: [URLQueryItem] = []

        if let page = page {
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
            queryItems.append(URLQueryItem(name: "page_size", value: "20" ))
        }

        if let query = query {
            queryItems.append(URLQueryItem(name: "search", value: query))
        }

        return Endpoint(path: "/games", queryItems: queryItems)
    }

    public static func gameDetail(id: Int) -> Endpoint {
        return Endpoint(path: "/games/\(id)", queryItems: nil)
    }

    public static func gameScreenshots(id: Int) -> Endpoint {
        return Endpoint(path: "/games/\(id)/screenshots", queryItems: nil)
    }

    public static func gameTrailers(id: Int) -> Endpoint {
        return Endpoint(path: "/games/\(id)/movies", queryItems: nil)
    }

}
