//
//  GetFavoriteGames.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation

public protocol GetFavoriteGames: Sendable {
    func execute() async -> [Game]
}

public final class GetFavoriteGamesImpl: GetFavoriteGames {
    public  let repository: FavoriteGamesRepository

    public init(repository: FavoriteGamesRepository) {
        self.repository = repository
    }

    public func execute() async -> [Game] {
        return await repository.getFavoriteGames()
    }
}
