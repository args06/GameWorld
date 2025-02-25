//
//  NavigationManager.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation
import SwiftUI

class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()

    func navigate(to destination: Destination) {
        path.append(destination)
    }

    func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    func goBackToRoot() {
        path.removeLast(path.count)
    }

    func clearStackAndNavigate(to destination: Destination) {
        DispatchQueue.main.async {
            self.path = NavigationPath()
            self.path.append(destination)
        }
    }
}

enum Destination: Hashable {
    case dashboard
    case gameDetail(Game)
    case profile
    case favorite
}
