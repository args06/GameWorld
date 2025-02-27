//
//  GameWorldApp.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import SwiftUI
import Core
import Navigation
import Domain
import Presentation

@main
struct GameWorldApp: App {
    @StateObject private var navigationManager = NavigationManager()
    private let viewFactory = AppViewFactory()

    init() {
        SetupApp.shared.start()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.path) {
                viewFactory.makeView(for: .dashboard)
                    .navigationDestination(for: Destination.self) { destination in
                        viewFactory.makeView(for: destination)
                    }
            }
            .environmentObject(navigationManager)
        }
    }
}
