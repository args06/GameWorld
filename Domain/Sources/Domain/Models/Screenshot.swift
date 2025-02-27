//
//  Screenshot.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

public struct Screenshot: Identifiable, Hashable, Sendable {
    public let id: Int
    public let url: String

    public init(id: Int, url: String) {
        self.id = id
        self.url = url
    }
}
