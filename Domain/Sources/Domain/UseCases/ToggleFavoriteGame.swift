//
//  ToggleFavoriteGame.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation

public protocol ToggleFavoriteGame: Sendable {
    func execute(game: Game) async
}

public final class ToggleFavoriteGameImpl: ToggleFavoriteGame {
    private let repository: FavoriteGamesRepository

    public init(repository: FavoriteGamesRepository) {
        self.repository = repository
    }

    public func execute(game: Game) async {
        let isFavorite = await repository.isFavoriteGame(gameId: game.id)

        do {
            if isFavorite {
                try await repository.removeFavoriteGame(gameId: game.id)
            } else {
                try await repository.saveFavoriteGame(game: game)
            }
        } catch {
            print("Error toggling favorite: \(error)")
        }
    }
}
