//
//  SearchGames.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 17/02/25.
//

import Foundation
import Combine

protocol SearchGames {
    func execute(page: Int?, query: String) -> AnyPublisher<GamesResponse, Error>
}

final class SearchGamesImpl: SearchGames {
    private let repository: GameRepository

    init(repository: GameRepository) {
        self.repository = repository
    }

    func execute(page: Int?, query: String) -> AnyPublisher<GamesResponse, Error> {
        return repository.searchGames(page: page, query: query)
    }
}
