//
//  Dependency Container.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

@propertyWrapper
public struct Inject<T> {
    public let wrappedValue: T

    public init() {
        self.wrappedValue = DependencyContainer.shared.resolve()
    }
}

public final class DependencyContainer: @unchecked Sendable {
    public static let shared = DependencyContainer()
    private var dependencies: [String: Any] = [:]
    public var isRegistered = false

    private let queue = DispatchQueue(label: "dependency.container.queue", attributes: .concurrent)

    public init() {}

    public func register<T>(type: T.Type, component: @autoclosure @escaping () -> T) {
        let key = String(describing: type)

        queue.sync {
            dependencies[key] = component
        }
    }

    public func register<T>(type: T.Type, component: @escaping () -> T) {
        let key = String(describing: type)

        queue.sync {
            dependencies[key] = component
        }
    }

    public func resolve<T>() -> T {
        var result: T?

        queue.sync {
            let key = String(describing: T.self)
            result = dependencies[key] as? T ?? (dependencies[key] as? () -> T)?()
        }

        if let resolved = result {
            return resolved
        }

        fatalError("Could not resolve dependency for \(T.self)")
    }
}
