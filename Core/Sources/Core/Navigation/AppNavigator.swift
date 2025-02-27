//
//  AppNavigator.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 26/02/25.
//

import Foundation
import SwiftUI

public typealias ObservableNavigator = ObservableObject & AppNavigator

public protocol AppNavigator {
    var path: NavigationPath { get set }
    func navigate<T: Hashable>(to route: T)
    func goBack()
    func goBackToRoot()
    func clearStackAndNavigate<T: Hashable>(to route: T)
}
