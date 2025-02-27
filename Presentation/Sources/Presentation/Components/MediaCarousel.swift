//
//  MediaCarousel.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 25/02/25.
//

import Foundation
import SwiftUI
import Domain

struct MediaCarousel: View {
    let mediaItems: [MediaType]
    @State private var selectedIndex = 0
    @StateObject private var videoViewModel = VideoPlayerViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TabView(selection: $selectedIndex) {
                ForEach(Array(mediaItems.enumerated()), id: \.offset) { index, media in

                    switch media {
                    case .video(let url, let thumbnail):
                        VideoPlayerView(
                            viewModel: videoViewModel,
                            url: url,
                            thumbnailUrl: thumbnail
                        )
                        .frame(height: 250)
                        .clipped()
                        .tag(index)
                    case .image(let url):
                        AsyncImage(url: URL(string: url)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                        }
                        .frame(height: 250)
                        .clipped()
                        .tag(index)
                    }
                }
            }
            .frame(height: 250)
            .tabViewStyle(.page)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onChange(of: selectedIndex) {  oldState, _ in

                if case .video = mediaItems[oldState] {
                    videoViewModel.pause()
                    videoViewModel.hasStartedPlayback = false
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(Array(mediaItems.enumerated()), id: \.offset) { index, media in
                        let isSelected = selectedIndex == index

                        switch media {
                        case .video(_, let thumbnail):
                            ThumbnailView(
                                systemName: "play.rectangle.fill",
                                isSelected: isSelected,
                                thumbnail: thumbnail,
                                hasThumbnail: !thumbnail.isEmpty
                            )
                            .onTapGesture {
                                selectedIndex = index
                            }
                        case .image(let url):
                            ThumbnailView(
                                systemName: "",
                                isSelected: isSelected,
                                thumbnail: url,
                                hasThumbnail: !url.isEmpty
                            )
                            .onTapGesture {
                                selectedIndex = index
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ThumbnailView: View {
    let systemName: String
    let isSelected: Bool
    let thumbnail: String
    let hasThumbnail: Bool

    var body: some View {
        ZStack {
            if hasThumbnail {
                asyncImage
            } else {
                defaultThumbnail
            }
        }
        .frame(width: 60, height: 40)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .overlay(selectionBorder)
    }

    private var asyncImage: some View {
        AsyncImage(url: URL(string: thumbnail)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
        }
    }

    private var defaultThumbnail: some View {
        ZStack {
            Color.black
            Image(systemName: systemName)
                .font(.title2)
                .foregroundColor(.white)
        }
    }

    private var selectionBorder: some View {
        RoundedRectangle(cornerRadius: 6)
            .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
    }
}
