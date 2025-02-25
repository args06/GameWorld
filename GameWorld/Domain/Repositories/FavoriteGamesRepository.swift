//
//  FavoriteGamesRepository.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation

protocol FavoriteGamesRepository {
    func saveFavoriteGame(game: Game) async throws
    func removeFavoriteGame(gameId: Int) async throws
    func isFavoriteGame(gameId: Int) async -> Bool
    func getFavoriteGames() async -> [Game]
}
