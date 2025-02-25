//
//  Dependency Container.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

@propertyWrapper
struct Inject<T> {
    let wrappedValue: T

    init() {
        self.wrappedValue = DependencyContainer.shared.resolve()
    }
}

final class DependencyContainer {
    static let shared = DependencyContainer()
    private var dependencies: [String: Any] = [:]
    private var isRegistered = false

    @MainActor
    func start() {
        guard !isRegistered else { return }
        registerDependencies()
        isRegistered = true
    }

    @MainActor
    private func registerDependencies() {
        let apiClient = APIClientImpl()
        register(type: APIClient.self, component: apiClient)

        register(type: GameRepository.self) { () -> GameRepository in
            return GameInteractor()
        }

        register(type: GameDetailRepository.self) { () -> GameDetailRepository in
            return GameDetailInteractor()
        }

        register(type: FavoriteGamesRepository.self) { () -> FavoriteGamesRepository in
            assert(Thread.isMainThread, "FavoriteGamesInteractor must be created on the main thread")

            do {
                return try FavoriteGamesInteractor()
            } catch {
                fatalError("Failed to create FavoriteGamesInteractor: \(error)")
            }
        }

        register(type: FetchGames.self) { [weak self] () -> FetchGames in
            guard let self = self else { fatalError("Self is nil") }
            return FetchGamesImpl(repository: self.resolve())
        }

        register(type: SearchGames.self) { [weak self] () -> SearchGames in
            guard let self = self else { fatalError("Self is nil") }
            return SearchGamesImpl(repository: self.resolve())
        }

        register(type: FetchGameDetail.self) { [weak self] () -> FetchGameDetail in
            guard let self = self else { fatalError("Self is nil") }
            return FetchGameDetailImpl(repository: self.resolve())
        }

        register(type: ToggleFavoriteGame.self) { [weak self] () -> ToggleFavoriteGame in
            guard let self = self else { fatalError("Self is nil") }
            return ToggleFavoriteGameImpl(repository: self.resolve())
        }

        register(type: CheckIsFavoriteGame.self) { [weak self] () -> CheckIsFavoriteGame in
            guard let self = self else { fatalError("Self is nil") }
            return CheckIsFavoriteGameImpl(repository: self.resolve())
        }

        register(type: GetFavoriteGames.self) { [weak self] () -> GetFavoriteGames in
            guard let self = self else { fatalError("Self is nil") }
            return GetFavoriteGamesImpl(repository: self.resolve())
        }
    }

    func register<T>(type: T.Type, component: @autoclosure @escaping () -> T) {
        dependencies[String(describing: type)] = component
    }

    func register<T>(type: T.Type, component: @escaping () -> T) {
        dependencies[String(describing: type)] = component
    }

    func resolve<T>() -> T {
        let key = String(describing: T.self)
        guard let component = dependencies[key] else {
            fatalError("No dependency found for \(key)")
        }

        if let component = component as? T {
            return component
        } else if let factory = component as? () -> T {
            return factory()
        }

        fatalError("Could not resolve dependency for \(key)")
    }
}
