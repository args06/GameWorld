//
//  GameRepository.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 17/02/25.
//

import Foundation
import Combine

protocol GameRepository {
    func fetchGames(page: Int?) -> AnyPublisher<GamesResponse, Error>
    func searchGames(page: Int?, query: String) -> AnyPublisher<GamesResponse, Error>
}
