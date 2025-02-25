//
//  FavoritesViewModel.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation
import Combine

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
            // Reload the favorites list after successful removal
            let updatedFavorites = await getFavoriteGames.execute()
            updateState(.success(updatedFavorites))
        }
    }

    private func updateState(_ newState: LoadingState<[Game]>) {
        DispatchQueue.main.async {
            self.favoritesState = newState
        }
    }

//    @Inject private var manageFavorites: ManageFavorites
//    private var cancellables = Set<AnyCancellable>()
//
//    func fetchFavorites() {
//        favoritesState = .loading
//
//        manageFavorites.getFavorites()
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] completion in
//                if case .failure(let error) = completion {
//                    self?.favoritesState = .error(error)
//                }
//            } receiveValue: { [weak self] games in
//                self?.favoritesState = .success(games)
//            }
//            .store(in: &cancellables)
//    }
//
//    func removeFromFavorites(_ gameId: Int) {
//        manageFavorites.removeFavorite(gameId)
//            .receive(on: DispatchQueue.main)
//            .sink { completion in
//                if case .failure(let error) = completion {
//                    print("Error removing favorite: \(error)")
//                }
//            } receiveValue: { [weak self] _ in
//                self?.fetchFavorites()
//            }
//            .store(in: &cancellables)
//    }
}
