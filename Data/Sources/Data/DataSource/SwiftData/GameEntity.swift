//
//  GameEntity.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import SwiftData
import Domain

@Model
public final class GameEntity {
    public var id: Int
    public var name: String
    public var released: String
    public var backgroundImage: String
    public var rating: Double
    public var genres: [String]
    public var gameDescription: String

    @Relationship(deleteRule: .cascade)
    public var screenshots: [ScreenshotEntity] = []

    @Relationship(deleteRule: .cascade)
    public var clips: [ClipEntity] = []

    public init(game: Game) {
        self.id = game.id
        self.name = game.name
        self.released = game.released
        self.backgroundImage = game.backgroundImage
        self.rating = game.rating
        self.genres = game.genres
        self.gameDescription = game.description
    }

    public func toDomain() -> Game {
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
