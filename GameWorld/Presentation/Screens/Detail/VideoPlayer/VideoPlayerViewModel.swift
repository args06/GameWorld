//
//  VideoPlayerViewModel.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import AVKit
import Foundation
import Combine

@MainActor
final class VideoPlayerViewModel: ObservableObject {
    @Published var isPlaying = false
    @Published var isLoading = true
    @Published var hasStartedPlayback = false

    private var player: AVPlayer?
    private var lastPosition: CMTime = .zero
    private var cancellables = Set<AnyCancellable>()

    var playerItem: AVPlayer? { player }

    func setupPlayer(with url: String) {
        guard let videoURL = URL(string: url) else { return }

        let player = AVPlayer(url: videoURL)
        self.player = player

        player.currentItem?.publisher(for: \.status)
            .receive(on: RunLoop.main)
            .sink { [weak self] status in
                if status == .readyToPlay {
                    self?.isLoading = false
                }
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.handleVideoEnd()
            }
            .store(in: &cancellables)
    }

    func togglePlayback() {
        if isPlaying {
            pause()
        } else {
            resume()
        }
    }

    func pause() {
        lastPosition = player?.currentTime() ?? .zero
        player?.pause()
        isPlaying = false
    }

    func resume() {
        player?.seek(to: lastPosition)
        player?.play()
        isPlaying = true

        if !hasStartedPlayback {
            hasStartedPlayback = true
        }
    }

    private func handleVideoEnd() {
        isPlaying = false
        lastPosition = .zero
    }
}
