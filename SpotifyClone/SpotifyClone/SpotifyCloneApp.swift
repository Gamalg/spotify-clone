//
//  SpotifyCloneApp.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.03.2023.
//

import SwiftUI
import SpotifyiOS

@main
struct SpotifyCloneApp: App {
    var body: some Scene {
        WindowGroup {
            SignInScreenView()
        }
    }
}

struct TextExample: View {
    var body: some View {
        VStack {
            Text("Large title")
                .font(.largeTitle)
            Text("Title")
                .font(.title)
            Text("Title 2")
                .font(.title2)
            Text("Title 3")
                .font(.title3)
            Text("Headline")
                .font(.headline)
            Text("Subheadline")
                .font(.subheadline)
            Text("Body")
                .font(.body)
            Text("Callout")
                .font(.callout)
            Text("Caption")
                .font(.caption)
            Text("Caption 2")
                .font(.caption2)
        }
    }
}
