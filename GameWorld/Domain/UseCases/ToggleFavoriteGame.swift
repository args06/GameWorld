//
//  ToggleFavoriteGame.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation

protocol ToggleFavoriteGame {
    func execute(game: Game) async
}

final class ToggleFavoriteGameImpl: ToggleFavoriteGame {
    private let repository: FavoriteGamesRepository
    
    init(repository: FavoriteGamesRepository) {
        self.repository = repository
    }
    
    func execute(game: Game) async {
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
