//
//  MediaType.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

public enum MediaType: Hashable {
    case image(url: String)
    case video(url: String, thumbnail: String)

    public var url: String {
        switch self {
        case .image(let url):
            return url
        case .video(let url, _):
            return url
        }
    }

    public var thumbnailUrl: String {
        switch self {
        case .image(let url):
            return url
        case .video(_, let thumbnail):
            return thumbnail
        }
    }

    public var isVideo: Bool {
        switch self {
        case .video:
            return true
        case .image:
            return false
        }
    }
}
