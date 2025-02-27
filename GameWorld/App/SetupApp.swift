//
//  DI.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 26/02/25.
//

import Foundation
import Core
import Domain
import Data

@MainActor
public final class SetupApp {
    public static let shared = SetupApp()

    let container = DependencyContainer.shared

    public init() {}

    public func start() {
        guard !container.isRegistered else { return }
        registerDependencies()
        container.isRegistered = true
        setupAPIKey()
    }

    public func registerDependencies() {
        let apiClient = APIClientImpl()
        container.register(type: APIClient.self, component: apiClient)

        container.register(type: GameRepository.self) { () -> GameRepository in
            return GameInteractor()
        }

        container.register(type: GameDetailRepository.self) { () -> GameDetailRepository in
            return GameDetailInteractor()
        }

        container.register(type: FavoriteGamesRepository.self) { () -> FavoriteGamesRepository in
            assert(Thread.isMainThread, "FavoriteGamesInteractor must be created on the main thread")

            do {
                return try FavoriteGamesInteractor()
            } catch {
                fatalError("Failed to create FavoriteGamesInteractor: \(error)")
            }
        }

        container.register(type: FetchGames.self) {
            FetchGamesImpl(repository: self.container.resolve())
        }

        container.register(type: SearchGames.self) {
            SearchGamesImpl(repository: self.container.resolve())
        }

        container.register(type: FetchGameDetail.self) {
            FetchGameDetailImpl(repository: self.container.resolve())
        }

        container.register(type: ToggleFavoriteGame.self) {
            ToggleFavoriteGameImpl(repository: self.container.resolve())
        }

        container.register(type: CheckIsFavoriteGame.self) {
            CheckIsFavoriteGameImpl(repository: self.container.resolve())
        }

        container.register(type: GetFavoriteGames.self) {
            GetFavoriteGamesImpl(repository: self.container.resolve())
        }
    }

    func setupAPIKey() {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let key = dict["API_KEY"] as? String {
            Configuration.shared.setAPIKey(key)
        }
    }

}
