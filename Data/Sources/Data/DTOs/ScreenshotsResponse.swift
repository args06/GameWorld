//
//  ScreenshotsResponseDTO.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation

public struct ScreenshotsResponse: Decodable {
    public let results: [ScreenshotDTO]
}
