//
//  Configuration.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

public final class Configuration: @unchecked Sendable {
    public static let shared = Configuration()

    private let queue = DispatchQueue(label: "com.gameworld.configuration")
    private var apiKey: String = "development_key"

    private init() {}

    public func getAPIKey() -> String {
        queue.sync {
            return apiKey
        }
    }

    public func setAPIKey(_ key: String) {
        queue.sync {
            apiKey = key
        }
    }
}
