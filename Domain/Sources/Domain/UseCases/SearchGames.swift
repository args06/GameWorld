//
//  SearchGames.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 17/02/25.
//

import Foundation
import Combine

public protocol SearchGames {
    func execute(page: Int?, query: String) -> AnyPublisher<GamePage, Error>
}

public final class SearchGamesImpl: SearchGames {
    public let repository: GameRepository

    public init(repository: GameRepository) {
        self.repository = repository
    }

    public func execute(page: Int?, query: String) -> AnyPublisher<GamePage, Error> {
        return repository.searchGames(page: page, query: query)
    }
}
