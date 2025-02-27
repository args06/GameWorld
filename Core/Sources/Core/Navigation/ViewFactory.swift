//
//  ViewFactory.swift
//  Core
//
//  Created by Anjar Harimurti on 27/02/25.
//

import Foundation
import SwiftUI

public protocol ViewFactory {
    associatedtype Dest: Hashable
    func makeView(for destination: Dest) -> AnyView
}
