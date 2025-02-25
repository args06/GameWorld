//
//  Router.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation
import SwiftUI

class Router {
    @ViewBuilder
    func view(for destination: Destination) -> some View {
        switch destination {
        case .dashboard:
            DashboardView()

        case .gameDetail(let game):
            GameDetailView(game: game)

        case .profile:
            ProfileView()

        case .favorite:
            FavoriteView()
        }
    }
}
