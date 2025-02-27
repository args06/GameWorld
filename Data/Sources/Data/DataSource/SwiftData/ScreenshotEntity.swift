//
//  ScreenshotEntity.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import SwiftData
import Domain

@Model
public final class ScreenshotEntity {
    public var id: Int
    public var url: String

    @Relationship(inverse: \GameEntity.screenshots)
    public var game: GameEntity?

    public init(screenshot: Screenshot) {
        self.id = screenshot.id
        self.url = screenshot.url
    }

    public func toDomain() -> Screenshot {
        return Screenshot(
            id: id,
            url: url
        )
    }
}
