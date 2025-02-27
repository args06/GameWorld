//
//  GameDetailRepository.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation
import Combine

public protocol GameDetailRepository {
    func fetchGameDetail(id: Int) -> AnyPublisher<Game, Error>
    func fetchGameScreenshots(id: Int) -> AnyPublisher<[Screenshot], Error>
    func fetchGameTrailers(id: Int) -> AnyPublisher<[Clip], Error>
}
