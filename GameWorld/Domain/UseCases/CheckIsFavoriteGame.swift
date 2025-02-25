//
//  CheckIsFavoriteGame.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation

protocol CheckIsFavoriteGame {
    func execute(gameId: Int) async -> Bool
}

final class CheckIsFavoriteGameImpl: CheckIsFavoriteGame {
    private let repository: FavoriteGamesRepository
    
    init(repository: FavoriteGamesRepository) {
        self.repository = repository
    }
    
    func execute(gameId: Int) async -> Bool {
        return await repository.isFavoriteGame(gameId: gameId)
    }
}
