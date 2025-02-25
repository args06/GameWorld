//
//  ScreenshotEntity.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import SwiftData

@Model
final class ScreenshotEntity {
    var id: Int
    var url: String
    
    @Relationship(inverse: \GameEntity.screenshots)
    var game: GameEntity?
    
    init(screenshot: Screenshot) {
        self.id = screenshot.id
        self.url = screenshot.url
    }
    
    func toDomain() -> Screenshot {
        return Screenshot(
            id: id,
            url: url
        )
    }
}
