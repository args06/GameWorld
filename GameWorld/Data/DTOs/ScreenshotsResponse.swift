//
//  ScreenshotsResponseDTO.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation

struct ScreenshotsResponse: Decodable {
    let results: [ScreenshotDTO]
}
