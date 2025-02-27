//
//  GameDetailView.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import SwiftUI
import Domain
import Navigation

struct GameDetailView: View {
    @StateObject private var viewModel = GameDetailViewModel()

    let game: Game
    var body: some View {

        LoadingView(
            state: viewModel.gameState,
            retryAction: { viewModel.loadGameDetail(id: game.id) },
            content: {
                ScrollView {
                    if case .success(let game) = viewModel.gameState {
                        VStack(alignment: .leading, spacing: 16) {

                            MediaCarousel(mediaItems: game.mediaItems)

                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Text(game.name)
                                        .font(.title)
                                        .fontWeight(.bold)

                                    Spacer()

                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundStyle(.yellow)
                                        Text(String(format: "%.1f", game.rating))
                                    }
                                }

                                HStack {
                                    Image(systemName: "calendar")
                                        .foregroundStyle(.blue)
                                    Text("Released: \(game.released.formatDate(dateFormat: .long))")
                                }
                                .foregroundStyle(.secondary)

                                if !game.genres.isEmpty {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Genres")
                                            .font(.headline)

                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack {
                                                ForEach(game.genres, id: \.self) { genre in
                                                    Text(genre)
                                                        .font(.caption)
                                                        .padding(.horizontal, 12)
                                                        .padding(.vertical, 6)
                                                        .background(
                                                            Capsule()
                                                                .fill(Color.blue.opacity(0.1))
                                                        )
                                                }
                                            }
                                        }
                                    }
                                }

                                if !game.description.isEmpty {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("About")
                                            .font(.headline)

                                        Text(game.description)
                                            .font(.body)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
        )
        .navigationTitle(game.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.toggleFavorite()
                } label: {
                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(viewModel.isFavorite ? .red : .gray)
                }
            }
        }
        .task {
            await viewModel.checkFavoriteStatus(id: game.id)
        }
        .onAppear {
            viewModel.loadGameDetail(id: game.id)
        }
    }
}

#Preview {
    GameDetailView(game: .sample)
}
