//
//  GameDetailRepository.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation
import Combine

protocol GameDetailRepository {
    func fetchGameDetail(id: Int) -> AnyPublisher<GameDTO, Error>
    func fetchGameScreenshots(id: Int) -> AnyPublisher<ScreenshotsResponse, Error>
    func fetchGameTrailers(id: Int) -> AnyPublisher<TrailersResponse, Error>
}
