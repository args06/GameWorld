//
//  FetchGames.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 17/02/25.
//

import Foundation
import Combine

public protocol FetchGames {
    func execute(page: Int?) -> AnyPublisher<GamePage, Error>
}

public final class FetchGamesImpl: FetchGames {
    private let repository: GameRepository

    public init(repository: GameRepository) {
        self.repository = repository
    }

    public func execute(page: Int?) -> AnyPublisher<GamePage, Error> {
        return repository.fetchGames(page: page)
    }
}
