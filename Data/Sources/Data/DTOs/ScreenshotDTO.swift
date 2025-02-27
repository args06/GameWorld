//
//  ScreenshotDTO.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation
import Domain

public struct ScreenshotDTO: Decodable {
    public let id: Int
    public let image: String
    public let isDeleted: Bool

    public enum CodingKeys: String, CodingKey {
        case id, image
        case isDeleted = "is_deleted"
    }
}

public extension ScreenshotDTO {
    public func toDomain() -> Screenshot {
        return Screenshot(
            id: id,
            url: image
        )
    }
}
