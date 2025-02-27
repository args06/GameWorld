//
//  DashboardView.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import SwiftUI
import Domain
import Navigation

public struct DashboardView: View {
    @StateObject private var viewModel = GamesViewModel()
    @EnvironmentObject private var router: NavigationManager

    public var body: some View {

        LoadingView(
            state: viewModel.gamesState,
            retryAction: viewModel.loadGames,
            content: {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        if case .success(let games) = viewModel.gamesState {
                            ForEach(games) { game in
                                GameRowView(game: game)
                                    .onAppear {
                                        viewModel.loadMoreIfNeeded(game: game)
                                    }
                                    .onTapGesture {
                                        router.navigate(to: Destination.gameDetail(game))
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)

                    if viewModel.isLoadingNextPage {
                        ProgressView()
                            .padding()
                    }
                }
            }
        )
        .onAppear {
            if case .idle = viewModel.gamesState {
                viewModel.loadGames()
            }
        }
        .searchable(
            text: $viewModel.searchText,
            prompt: "Search games..."
        )
        .onChange(of: viewModel.searchText) { oldValue, newValue in
            if !oldValue.isEmpty && newValue.isEmpty {
                viewModel.refresh()
            }
        }
        .refreshable {
            viewModel.refresh()
        }
        .navigationTitle("Game World")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    router.navigate(to: Destination.profile)
                } label: {
                    Image(systemName: "person.circle.fill")
                        .font(.title2)
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    router.navigate(to: Destination.favorite)
                } label: {
                    Image(systemName: "heart.fill")
                        .font(.title2)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DashboardView()
            .environmentObject(NavigationManager())
    }
}
