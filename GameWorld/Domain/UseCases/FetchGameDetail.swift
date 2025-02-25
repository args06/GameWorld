//
//  GetGameDetail.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation
import Combine

protocol FetchGameDetail {
    func execute(id: Int) -> AnyPublisher<Game, Error>
}

final class FetchGameDetailImpl: FetchGameDetail {
    private let repository: GameDetailRepository

    init(repository: GameDetailRepository) {
        self.repository = repository
    }

    func execute(id: Int) -> AnyPublisher<Game, Error> {
        let gameDetail = repository.fetchGameDetail(id: id)
        let screenshots = repository.fetchGameScreenshots(id: id)
        let trailers = repository.fetchGameTrailers(id: id)

        return Publishers.CombineLatest3(gameDetail, screenshots, trailers)
            .map { gameDTO, screenshotsDTO, trailersDTO in
                let screenshots = screenshotsDTO.results.map { $0.toDomain() }
                let clips = trailersDTO.results.map { $0.toDomain() }
                return gameDTO.toDomain(screenshots: screenshots, clips: clips)
            }
            .eraseToAnyPublisher()
    }
}
