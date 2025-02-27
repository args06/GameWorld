//
//  Clip.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

public struct Clip: Identifiable, Hashable, Sendable {
    public let id: Int
    public let name: String
    public let previewUrl: String
    public let videoUrl: String

    public init(id: Int, name: String, previewUrl: String, videoUrl: String) {
        self.id = id
        self.name = name
        self.previewUrl = previewUrl
        self.videoUrl = videoUrl
    }
}
