//
//  FavoritesViewModel.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation
import Combine
import Core
import Domain

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published private(set) var favoritesState: LoadingState<[Game]> = .idle

    @Inject private var getFavoriteGames: GetFavoriteGames
    @Inject private var toggleFavoriteGame: ToggleFavoriteGame

    func loadFavorites() {
        updateState(.loading)

        Task {
            let favorites = await getFavoriteGames.execute()
            updateState(.success(favorites))
        }
    }

    func removeFromFavorites(gameId: Int) {
        guard case .success(let currentGames) = favoritesState,
              let gameToRemove = currentGames.first(where: { $0.id == gameId }) else {
            return
        }

        updateState(.loading)

        Task {
            await toggleFavoriteGame.execute(game: gameToRemove)

            let updatedFavorites = await getFavoriteGames.execute()
            updateState(.success(updatedFavorites))
        }
    }

    private func updateState(_ newState: LoadingState<[Game]>) {
        DispatchQueue.main.async {
            self.favoritesState = newState
        }
    }
}
