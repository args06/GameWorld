//
//  GetGameDetail.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation
import Combine

public protocol FetchGameDetail {
    func execute(id: Int) -> AnyPublisher<Game, Error>
}

public final class FetchGameDetailImpl: FetchGameDetail {
    public  let repository: GameDetailRepository

    public init(repository: GameDetailRepository) {
        self.repository = repository
    }

    public func execute(id: Int) -> AnyPublisher<Game, Error> {
            let gameDetail = repository.fetchGameDetail(id: id)
            let screenshots = repository.fetchGameScreenshots(id: id)
            let trailers = repository.fetchGameTrailers(id: id)

            return Publishers.CombineLatest3(gameDetail, screenshots, trailers)
                .map { game, screenshots, clips -> Game in
                    game.combineData(screenshots: screenshots, clips: clips)
                }
                .eraseToAnyPublisher()
        }
}
