//
//  ClipEntity.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import SwiftData

@Model
final class ClipEntity {
    var id: Int
    var name: String
    var previewUrl: String
    var videoUrl: String
    
    @Relationship(inverse: \GameEntity.clips)
    var game: GameEntity?
    
    init(clip: Clip) {
        self.id = clip.id
        self.name = clip.name
        self.previewUrl = clip.previewUrl
        self.videoUrl = clip.videoUrl
    }
    
    func toDomain() -> Clip {
        return Clip(
            id: id,
            name: name,
            previewUrl: previewUrl,
            videoUrl: videoUrl
        )
    }
}
