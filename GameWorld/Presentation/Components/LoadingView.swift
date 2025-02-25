//
//  LoadingView.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 17/02/25.
//

import Foundation
import SwiftUI

struct LoadingView<T, Content: View>: View {
    let state: LoadingState<T>
    let retryAction: (() -> Void)?
    @ViewBuilder let content: Content

    var body: some View {
        switch state {
        case .idle, .loading:
            ProgressView()
                .padding()
        case .success:
            content
        case .error(let error):
            VStack(spacing: 16) {
                Text("Something went wrong")
                    .font(.headline)
                Text(error.localizedDescription)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                if let retryAction {
                    Button(action: retryAction) {
                        Text("Retry")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}
