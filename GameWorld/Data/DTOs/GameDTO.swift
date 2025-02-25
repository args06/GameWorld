//
//  GameDTO.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

struct GameDTO: Decodable {
    let id: Int
    let name: String
    let released: String?
    let backgroundImage: String?
    let rating: Double
    let genres: [GenreDTO]
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id, name, released, rating, genres
        case description = "description_raw"
        case backgroundImage = "background_image"
    }
}

extension GameDTO {
    func toDomain() -> Game {
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

    func toDomain(screenshots: [Screenshot], clips: [Clip]) -> Game {
        return Game(
            id: id,
            name: name,
            released: released ?? "TBA",
            backgroundImage: backgroundImage ?? "",
            rating: rating,
            genres: genres.map { $0.name },
            description: description ?? "",
            screenshots: screenshots,
            clips: clips
        )
    }
}
