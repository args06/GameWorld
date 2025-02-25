//
//  GameInteractor.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 17/02/25.
//

import Foundation
import Combine

final class GameInteractor: GameRepository {
    @Inject private var apiClient: APIClient

    func fetchGames(page: Int?) -> AnyPublisher<GamesResponse, Error> {
        return apiClient.fetch(from: .fetchGames(page: page))
            .eraseToAnyPublisher()
    }

    func searchGames(page: Int?, query: String) -> AnyPublisher<GamesResponse, any Error> {
        return apiClient.fetch(from: .fetchGames(page: page, query: query))
            .eraseToAnyPublisher()
    }
}
