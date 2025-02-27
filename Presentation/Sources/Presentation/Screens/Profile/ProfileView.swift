//
//  ProfileView.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image("photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: 4)
                    )
                    .shadow(radius: 7)

                VStack(spacing: 8) {
                    Text("Muhammad Anjar Harimurti Rahadi")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Mobile Developer")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 16) {
                    InfoRow(
                        icon: "envelope.fill",
                        title: "Email",
                        value: "anjarharimurti.dev@gmail.com"
                    )
                    InfoRow(
                        icon: "location.fill",
                        title: "Location",
                        value: "Malang, Indonesia"
                    )
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground))
                        .shadow(radius: 2)
                )
                .padding(.horizontal)
            }
            .padding(.vertical, 32)
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
