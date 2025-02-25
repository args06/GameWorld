//
//  GameEntity.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import SwiftData

@Model
final class GameEntity {
    var id: Int
    var name: String
    var released: String
    var backgroundImage: String
    var rating: Double
    var genres: [String]
    var gameDescription: String

    @Relationship(deleteRule: .cascade)
    var screenshots: [ScreenshotEntity] = []
    
    @Relationship(deleteRule: .cascade)
    var clips: [ClipEntity] = []
    
    init(game: Game) {
        self.id = game.id
        self.name = game.name
        self.released = game.released
        self.backgroundImage = game.backgroundImage
        self.rating = game.rating
        self.genres = game.genres
        self.gameDescription = game.description
    }
    
    func toDomain() -> Game {
        return Game(
            id: id,
            name: name,
            released: released,
            backgroundImage: backgroundImage,
            rating: rating,
            genres: genres,
            description: gameDescription,
            screenshots: screenshots.map { $0.toDomain() },
            clips: clips.map { $0.toDomain() }
        )
    }
}
