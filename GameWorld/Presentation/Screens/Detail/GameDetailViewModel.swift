//
//  GameDetailViewModel.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation
import Combine

@MainActor
final class GameDetailViewModel: ObservableObject {
    @Published private(set) var gameState: LoadingState<Game> = .idle
    @Published private(set) var isFavorite = false

    @Inject private var fetchGameDetail: FetchGameDetail
    @Inject private var toggleFavoriteGame: ToggleFavoriteGame
    @Inject private var checkIsFavoriteGame: CheckIsFavoriteGame

    private var cancellables = Set<AnyCancellable>()

    func loadGameDetail(id: Int) {
        updateState(.loading)

        fetchGameDetail.execute(id: id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.updateState(.error(error))
                }
            } receiveValue: { [weak self] game in
                self?.updateState(.success(game))
            }
            .store(in: &cancellables)
    }

    func checkFavoriteStatus(id: Int) async {
        let status = await checkIsFavoriteGame.execute(gameId: id)
        await MainActor.run {
            self.isFavorite = status
        }
    }

    func toggleFavorite() {
        guard case .success(let game) = gameState else { return }

        Task {
            await toggleFavoriteGame.execute(game: game)
            await checkFavoriteStatus(id: game.id)
        }
    }

    private func updateState(_ newState: LoadingState<Game>) {
        DispatchQueue.main.async {
            self.gameState = newState
        }
    }

    func refresh(id: Int) {
        loadGameDetail(id: id)
    }

    deinit {
        cancellables.removeAll()
    }
}
