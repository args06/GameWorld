//
//  GetFavoriteGames.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation

protocol GetFavoriteGames {
    func execute() async -> [Game]
}

final class GetFavoriteGamesImpl: GetFavoriteGames {
    private let repository: FavoriteGamesRepository
    
    init(repository: FavoriteGamesRepository) {
        self.repository = repository
    }
    
    func execute() async -> [Game] {
        return await repository.getFavoriteGames()
    }
}
