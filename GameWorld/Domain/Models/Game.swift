//
//  Game.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

struct Game: Identifiable, Hashable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    let genres: [String]
    let description: String
    let screenshots: [Screenshot]
    let clips: [Clip]

    var mediaItems: [MediaType] {
        var items: [MediaType] = []

        items.append(contentsOf: clips.map {
            MediaType.video(url: $0.videoUrl, thumbnail: $0.previewUrl)
        })

        items.append(contentsOf: screenshots.map {
            MediaType.image(url: $0.url)
        })

        return items
    }

    var firstMediaItem: MediaType? {
        return mediaItems.first
    }
}

extension Game {
    static let sample = Game(
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
