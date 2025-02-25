//
//  GameResponse.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

struct GamesResponse: Decodable {
    let next: String?
    let results: [GameDTO]
}
