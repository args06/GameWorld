//
//  VideoPlayerView.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation
import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @ObservedObject var viewModel: VideoPlayerViewModel
    let url: String
    let thumbnailUrl: String

    var body: some View {
        ZStack {
            if !viewModel.hasStartedPlayback {
                AsyncImage(url: URL(string: thumbnailUrl)) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color.black.opacity(0.1))
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                    @unknown default:
                        EmptyView()
                    }
                }
                .transition(.opacity)
            }

            // Video player
            if let player = viewModel.playerItem {
                VideoPlayer(player: player)
                    .opacity(viewModel.hasStartedPlayback ? 1 : 0)
            }

            Button {
                viewModel.togglePlayback()
            } label: {
                Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .opacity(viewModel.isPlaying ? 0.3 : 0.7)
            }

        }
        .onAppear {
            viewModel.setupPlayer(with: url)
        }
    }
}
