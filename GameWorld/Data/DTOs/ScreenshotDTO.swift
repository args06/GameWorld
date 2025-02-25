//
//  ScreenshotDTO.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation

struct ScreenshotDTO: Decodable {
    let id: Int
    let image: String
    let isDeleted: Bool

    enum CodingKeys: String, CodingKey {
        case id, image
        case isDeleted = "is_deleted"
    }
}

extension ScreenshotDTO {
    func toDomain() -> Screenshot {
        return Screenshot(
            id: id,
            url: image
        )
    }
}
