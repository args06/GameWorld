//
//  GamePage.swift
//  Domain
//
//  Created by Anjar Harimurti on 26/02/25.
//

import Foundation

public struct GamePage {
    public let games: [Game]
    public let nextPage: Int?

    public init(games: [Game], nextPage: Int?) {
        self.games = games
        self.nextPage = nextPage
    }
}
