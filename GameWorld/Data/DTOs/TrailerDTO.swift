//
//  TrailerDTO.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation

struct TrailerDTO: Decodable {
    let id: Int
    let name: String
    let preview: String
    let data: TrailerDataDTO
}

extension TrailerDTO {
    func toDomain() -> Clip {
        return Clip(
            id: id,
            name: name,
            previewUrl: preview,
            videoUrl: data.max
        )
    }
}
