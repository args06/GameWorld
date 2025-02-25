//
//  FetchGames.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 17/02/25.
//

import Foundation
import Combine

protocol FetchGames {
    func execute(page: Int?) -> AnyPublisher<GamesResponse, Error>
}

final class FetchGamesImpl: FetchGames {
    private let repository: GameRepository

    init(repository: GameRepository) {
        self.repository = repository
    }

    func execute(page: Int?) -> AnyPublisher<GamesResponse, Error> {
        return repository.fetchGames(page: page)
    }
}
