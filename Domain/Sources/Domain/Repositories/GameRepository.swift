//
//  GameRepository.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 17/02/25.
//

import Foundation
import Combine

public protocol GameRepository {
    func fetchGames(page: Int?) -> AnyPublisher<GamePage, Error>
    func searchGames(page: Int?, query: String) -> AnyPublisher<GamePage, Error>
}
