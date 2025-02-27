//
//  GameInteractor.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 17/02/25.
//

import Foundation
import Core
import Data
import Combine
import Domain

public final class GameInteractor: GameRepository {
    @Inject private var apiClient: APIClient

    public init() {}

    public func fetchGames(page: Int?) -> AnyPublisher<GamePage, Error> {
        return apiClient.fetch(from: .fetchGames(page: page))
            .map { (gamesResponse: GamesResponse) -> GamePage in
                let games = gamesResponse.results.map { $0.toDomain() }
                let nextPage = gamesResponse.next != nil ? (page ?? 1) + 1 : nil
                return GamePage(
                    games: games,
                    nextPage: nextPage
                )
            }
            .eraseToAnyPublisher()
    }

    public func searchGames(page: Int?, query: String) -> AnyPublisher<GamePage, any Error> {
        return apiClient.fetch(from: .fetchGames(page: page, query: query))
            .map { (gamesResponse: GamesResponse) -> GamePage in
                let games = gamesResponse.results.map { $0.toDomain() }
                let nextPage = gamesResponse.next != nil ? (page ?? 1) + 1 : nil
                return GamePage(
                    games: games,
                    nextPage: nextPage
                )
            }
            .eraseToAnyPublisher()
    }
}
