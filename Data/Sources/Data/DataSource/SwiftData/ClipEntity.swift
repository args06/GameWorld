//
//  ClipEntity.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import SwiftData
import Domain

@Model
public final class ClipEntity {
    public var id: Int
    public var name: String
    public var previewUrl: String
    public var videoUrl: String

    @Relationship(inverse: \GameEntity.clips)
    public var game: GameEntity?

    public init(clip: Clip) {
        self.id = clip.id
        self.name = clip.name
        self.previewUrl = clip.previewUrl
        self.videoUrl = clip.videoUrl
    }

    public func toDomain() -> Clip {
        return Clip(
            id: id,
            name: name,
            previewUrl: previewUrl,
            videoUrl: videoUrl
        )
    }
}
