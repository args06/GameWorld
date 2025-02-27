//
//  GameResponse.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

public struct GamesResponse: Decodable {
    public let next: String?
    public let results: [GameDTO]
}
