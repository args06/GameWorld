//
//  NavigationManager.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation
import SwiftUI
import Domain
import Core

public class NavigationManager: ObservableObject, AppNavigator {

    @Published public var path = NavigationPath()

    public init() {}

    public func navigate<T: Hashable>(to destination: T) {
        path.append(destination)
    }

    public func goBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    public func goBackToRoot() {
        path.removeLast(path.count)
    }

    public func clearStackAndNavigate<T>(to destination: T) where T: Hashable {
        self.path = NavigationPath()
        self.path.append(destination)
    }
}
