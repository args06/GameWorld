//
//  Endpoint.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]?
    let searchQuery: String?

    init(path: String, queryItems: [URLQueryItem]?, searchQuery: String? = nil) {
        self.path = path
        var items = queryItems ?? []
        items.append(URLQueryItem(name: "key", value: Configuration.getAPIKey()))
        self.queryItems = items
        self.searchQuery = searchQuery
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.rawg.io"
        components.path = "/api" + path
        components.queryItems = queryItems
        return components.url
    }
}

extension Endpoint {

    static func fetchGames(page: Int? = nil, query: String? = nil) -> Endpoint {
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

    static func gameDetail(id: Int) -> Endpoint {
        return Endpoint(path: "/games/\(id)", queryItems: nil)
    }

    static func gameScreenshots(id: Int) -> Endpoint {
        return Endpoint(path: "/games/\(id)/screenshots", queryItems: nil)
    }

    static func gameTrailers(id: Int) -> Endpoint {
        return Endpoint(path: "/games/\(id)/movies", queryItems: nil)
    }

}
