//
//  FavoriteGamesInteractor.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation
import SwiftData
import Domain

@MainActor
public final class FavoriteGamesInteractor: FavoriteGamesRepository {
    private let modelContainer: ModelContainer
    private let context: ModelContext

    public init() throws {
        let schema = Schema([GameEntity.self, ScreenshotEntity.self, ClipEntity.self])
        self.modelContainer = try ModelContainer(for: schema)
        self.context = modelContainer.mainContext
    }

    public func saveFavoriteGame(game: Game) async throws {
        let gameId = game.id
        let descriptor = FetchDescriptor<GameEntity>(predicate: #Predicate<GameEntity> { entity in
            entity.id == gameId
        })

        if (try? context.fetch(descriptor).first) != nil {
            return
        }

        let gameEntity = GameEntity(game: game)
        context.insert(gameEntity)

        for screenshot in game.screenshots {
            let screenshotEntity = ScreenshotEntity(screenshot: screenshot)
            context.insert(screenshotEntity)
            gameEntity.screenshots.append(screenshotEntity)
        }

        for clip in game.clips {
            let clipEntity = ClipEntity(clip: clip)
            context.insert(clipEntity)
            gameEntity.clips.append(clipEntity)
        }

        try context.save()
    }

    public func removeFavoriteGame(gameId: Int) async throws {
        let descriptor = FetchDescriptor<GameEntity>(predicate: #Predicate<GameEntity> { entity in
            entity.id == gameId
        })

        if let entity = try? context.fetch(descriptor).first {
            context.delete(entity)
            try context.save()
        }
    }

    public func isFavoriteGame(gameId: Int) async -> Bool {
        let descriptor = FetchDescriptor<GameEntity>(predicate: #Predicate<GameEntity> { entity in
            entity.id == gameId
        })

        do {
            let result = try context.fetch(descriptor)
            return !result.isEmpty
        } catch {
            return false
        }
    }

    public func getFavoriteGames() async -> [Game] {
        let descriptor = FetchDescriptor<GameEntity>()

        do {
            let entities = try context.fetch(descriptor)
            return entities.map { $0.toDomain() }
        } catch {
            return []
        }
    }
}
