//
//  GameViewModel.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 17/02/25.
//

import Foundation
import Combine
import Core
import Domain

@MainActor
final class GamesViewModel: ObservableObject {
    @Published private(set) var gamesState: LoadingState<[Game]> = .idle
    @Published var searchText = ""

    @Inject private var fetchGames: FetchGames
    @Inject private var searchGames: SearchGames

    private var cancellables = Set<AnyCancellable>()

    @Published private(set) var hasMoreContent = true
    private var currentPage = 1
    private var canLoadMore = true
    @Published var isLoadingNextPage = false

    init() {
        setupSearchSubscription()
    }

    private func setupSearchSubscription() {
        $searchText
            .dropFirst()
            .removeDuplicates()
            .debounce(for: .milliseconds(1500), scheduler: DispatchQueue.main)
            .sink { [weak self] query in
                if !query.isEmpty {
                    self?.handleSearchTextChange(query)
                }
            }
            .store(in: &cancellables)
    }

    private func handleSearchTextChange(_ query: String) {
        currentPage = 1
        canLoadMore = true

        if query.isEmpty {
            loadGames()
        } else {
            searchGames(query: query)
        }
    }

    @MainActor
    func loadGames() {
        guard !gamesState.isLoading else { return }

        let isFirstPage = currentPage == 1
        if isFirstPage {
            updateState(.loading)
        }

        fetchGames.execute(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.updateState(.error(error))
                    self?.isLoadingNextPage = false
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                let newGames = response.games

                if isFirstPage {
                    self.updateState(.success(newGames))
                } else if case .success(let existingGames) = self.gamesState {
                    self.updateState(.success(existingGames + newGames))
                }

                self.canLoadMore = response.nextPage != nil
                self.currentPage += 1
                self.isLoadingNextPage = false
            }
            .store(in: &cancellables)
    }

    @MainActor
    private func searchGames(query: String) {
        guard !gamesState.isLoading else { return }

        let isFirstPage = currentPage == 1
        if isFirstPage {
            updateState(.loading)
        }

        searchGames.execute(page: currentPage, query: searchText)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.updateState(.error(error))
                    self?.isLoadingNextPage = false
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                let newGames = response.games

                if isFirstPage {
                    self.updateState(.success(newGames))
                } else if case .success(let existingGames) = self.gamesState {
                    self.updateState(.success(existingGames + newGames))
                }

                self.canLoadMore = response.nextPage != nil
                self.currentPage += 1
                self.isLoadingNextPage = false
            }
            .store(in: &cancellables)
    }

    func loadMoreIfNeeded(game: Game) {
        guard case .success(let games) = gamesState,
              let index = games.firstIndex(where: { $0.id == game.id }),
              index == games.count - 3,
              canLoadMore && !isLoadingNextPage else {
            return
        }

        isLoadingNextPage = true

        if searchText.isEmpty {
            loadGames()
        } else {
            searchGames(query: searchText)
        }
    }

    func refresh() {
        cancellables.removeAll()
        currentPage = 1
        canLoadMore = true
        isLoadingNextPage = false
        if searchText.isEmpty {
            loadGames()
        } else {
            searchGames(query: searchText)
        }
        setupSearchSubscription()
    }

    private func updateState(_ newState: LoadingState<[Game]>) {
        DispatchQueue.main.async {
            self.gamesState = newState
        }
    }

    func cleanup() {
        cancellables.removeAll()
    }
}
