//
//  GameDetailInteractor.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation
import Combine

final class GameDetailInteractor: GameDetailRepository {
    @Inject private var apiClient: APIClient

    func fetchGameDetail(id: Int) -> AnyPublisher<GameDTO, Error> {
        return apiClient.fetch(from: .gameDetail(id: id))
            .eraseToAnyPublisher()
    }

    func fetchGameScreenshots(id: Int) -> AnyPublisher<ScreenshotsResponse, Error> {
        return apiClient.fetch(from: .gameScreenshots(id: id))
            .eraseToAnyPublisher()
    }

    func fetchGameTrailers(id: Int) -> AnyPublisher<TrailersResponse, Error> {
        return apiClient.fetch(from: .gameTrailers(id: id))
            .eraseToAnyPublisher()
    }
}
