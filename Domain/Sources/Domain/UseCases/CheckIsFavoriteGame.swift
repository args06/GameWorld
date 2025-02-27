//
//  CheckIsFavoriteGame.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation

public protocol CheckIsFavoriteGame: Sendable {
    func execute(gameId: Int) async -> Bool
}

public final class CheckIsFavoriteGameImpl: CheckIsFavoriteGame {
    public let repository: FavoriteGamesRepository

    public init(repository: FavoriteGamesRepository) {
        self.repository = repository
    }

    public func execute(gameId: Int) async -> Bool {
        return await repository.isFavoriteGame(gameId: gameId)
    }
}
