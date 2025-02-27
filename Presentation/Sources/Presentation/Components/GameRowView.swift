//
//  GameRowView.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 17/02/25.
//

import Foundation
import SwiftUI
import Domain
import Core

struct GameRowView: View {
    let game: Game

    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: game.backgroundImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(game.name)
                    .font(.headline)
                    .lineLimit(2)

                Text(game.released.formatDate(dateFormat: .medium))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.1f", game.rating))
                }
                .font(.caption)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    GameRowView(game: .sample)
}
