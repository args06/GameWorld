//
//  GameWorldApp.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import SwiftUI

@main
struct GameWorldApp: App {
    @StateObject private var navigationManager = NavigationManager()
    private var router = Router()

    init() {
        DependencyContainer.shared.start()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.path) {
                router.view(for: .dashboard)
                    .navigationDestination(for: Destination.self) { destination in
                        router.view(for: destination)
                    }
            }
            .environmentObject(navigationManager)
        }
    }
}
