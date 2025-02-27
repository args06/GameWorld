//
//  AppViewFactory.swift
//  Presentation
//
//  Created by Anjar Harimurti on 27/02/25.
//

import Foundation
import SwiftUI
import Core
import Domain

public struct AppViewFactory: @preconcurrency ViewFactory {
    public typealias Dest = Destination

    public init() {}

    @MainActor public func makeView(for destination: Destination) -> AnyView {
        switch destination {
        case .dashboard:
            return AnyView(DashboardView())
        case .gameDetail(let game):
            return AnyView(GameDetailView(game: game))
        case .profile:
            return AnyView(ProfileView())
        case .favorite:
            return AnyView(FavoriteView())
        }
    }
}
