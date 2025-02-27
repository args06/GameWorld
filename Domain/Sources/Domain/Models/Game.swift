//
//  Game.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

public struct Game: Identifiable, Hashable, Sendable {
    public let id: Int
    public let name: String
    public let released: String
    public let backgroundImage: String
    public let rating: Double
    public let genres: [String]
    public let description: String
    public let screenshots: [Screenshot]
    public let clips: [Clip]

    public init(
        id: Int,
        name: String,
        released: String,
        backgroundImage: String,
        rating: Double,
        genres: [String],
        description: String,
        screenshots: [Screenshot],
        clips: [Clip]) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.genres = genres
        self.description = description
        self.screenshots = screenshots
        self.clips = clips
    }

    public var mediaItems: [MediaType] {
        var items: [MediaType] = []

        items.append(contentsOf: clips.map {
            MediaType.video(url: $0.videoUrl, thumbnail: $0.previewUrl)
        })

        items.append(contentsOf: screenshots.map {
            MediaType.image(url: $0.url)
        })

        return items
    }

    public var firstMediaItem: MediaType? {
        return mediaItems.first
    }
}

public extension Game {
    public func combineData(screenshots: [Screenshot], clips: [Clip]) -> Game {
        return Game(
            id: id,
            name: name,
            released: released ?? "TBA",
            backgroundImage: backgroundImage ?? "",
            rating: rating,
            genres: genres.map { $0 },
            description: description ?? "",
            screenshots: screenshots,
            clips: clips
        )
    }

    public static let sample = Game(
        id: 3498,
        name: "Grand Theft Auto V",
        released: "2013-09-17",
        backgroundImage: "https://media.rawg.io/media/games/b11/b115b2bc6a5957a917bc7601f4abdda2.jpg",
        rating: 4.47,
        genres: ["Action", "Shooter"],
        description: "Grand Theft Auto V is an action-adventure game developed by Rockstar North...",
        screenshots: [
            Screenshot(id: 1, url: "https://media.rawg.io/media/games/b11/b115b2bc6a5957a917bc7601f4abdda2.jpg"),
            Screenshot(id: 2, url: "https://media.rawg.io/media/screenshots/1b4/1b4eefb4cc2a77d4d35bb4a6926f3189.jpg")
        ],
        clips: [
            Clip(
                id: 1,
                name: "Test",
                previewUrl: "https://media.rawg.io/media/stories-previews/f65/f6593df6c8df32c7f4763f9cb112a514.jpg",
                videoUrl: "https://media.rawg.io/media/stories-640/5b0/5b0cfff8c606c5e4db4f74f108c4413b.mp4"
            )
        ]
    )
}
