//
//  NetworkError.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

public enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData(Error)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid server response"
        case .invalidData(let error):
            return "Invalid data: \(error.localizedDescription)"
        }
    }
}
