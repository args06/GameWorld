//
//  Configuration.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

struct Configuration {
    private init() {}

    private static let apiKey: String = {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["API_KEY"] as? String else {
            fatalError("API Key not found in Info.plist")
        }
        return key
    }()

    static func getAPIKey() -> String {
        return apiKey
    }
}
