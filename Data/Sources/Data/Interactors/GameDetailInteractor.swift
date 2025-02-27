//
//  GameDetailInteractor.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation
import Combine
import Core
import Data
import Domain

public final class GameDetailInteractor: GameDetailRepository {
    @Inject private var apiClient: APIClient

    public init() {}

    public func fetchGameDetail(id: Int) -> AnyPublisher<Game, Error> {
        return apiClient.fetch(from: .gameDetail(id: id))
            .map { (gameDTO: GameDTO) -> Game in
                return gameDTO.toDomain()
            }
            .eraseToAnyPublisher()
    }

    public func fetchGameScreenshots(id: Int) -> AnyPublisher<[Screenshot], Error> {
        return apiClient.fetch(from: .gameScreenshots(id: id))
            .map { (response: ScreenshotsResponse) -> [Screenshot] in
                return response.results.map { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }

    public func fetchGameTrailers(id: Int) -> AnyPublisher<[Clip], Error> {
        return apiClient.fetch(from: .gameTrailers(id: id))
            .map { (response: TrailersResponse) -> [Clip] in
                return response.results.map { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }
}
