//
//  FavoriteView.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    @EnvironmentObject private var router: NavigationManager

    var body: some View {
        LoadingView(
            state: viewModel.favoritesState,
            retryAction: { viewModel.loadFavorites()
            },
            content: {
                if case .success(let games) = viewModel.favoritesState {
                    if games.isEmpty {
                        ContentUnavailableView("No favorite games yet", systemImage: "heart.slash")
                    } else {
                        List(games) { game in
                            GameRowView(game: game)
                                .onTapGesture {
                                    router.navigate(to: .gameDetail(game))
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        viewModel
                                            .removeFromFavorites(gameId: game.id)
                                    } label: {
                                        Label("Remove", systemImage: "heart.slash")
                                    }
                                }
                        }
                        .listStyle(.plain)
                    }
                }
            }
        )
        .navigationTitle("Favorites")
        .onAppear {
            viewModel.loadFavorites()
        }
        .refreshable {
            viewModel.loadFavorites()
        }
    }
}

#Preview {
    NavigationStack {
        FavoriteView()
    }
}
