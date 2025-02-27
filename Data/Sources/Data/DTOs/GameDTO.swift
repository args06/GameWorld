//
//  GameDTO.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation
import Domain

public struct GameDTO: Decodable {
    public let id: Int
    public let name: String
    public let released: String?
    public let backgroundImage: String?
    public let rating: Double
    public let genres: [GenreDTO]
    public let description: String?

    public enum CodingKeys: String, CodingKey {
        case id, name, released, rating, genres
        case description = "description_raw"
        case backgroundImage = "background_image"
    }
}

public extension GameDTO {
    public func toDomain() -> Game {
        return Game(
            id: id,
            name: name,
            released: released ?? "TBA",
            backgroundImage: backgroundImage ?? "",
            rating: rating,
            genres: genres.map { $0.name },
            description: description ?? "",
            screenshots: [],
            clips: []
        )
    }
}
