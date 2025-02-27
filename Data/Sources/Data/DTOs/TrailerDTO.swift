//
//  TrailerDTO.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation
import Domain

public struct TrailerDTO: Decodable {
    public let id: Int
    public let name: String
    public let preview: String
    public let data: TrailerDataDTO
}

public extension TrailerDTO {
    public func toDomain() -> Clip {
        return Clip(
            id: id,
            name: name,
            previewUrl: preview,
            videoUrl: data.max
        )
    }
}
