//
//  HomePageView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 25.04.2023.
//

import SwiftUI

struct HomePageView: View {
    @State var playlistName = ""
    @State var image = Image("")
    var body: some View {
        VStack {
            Text("Good day")
            Text("Your playlist:")

            HStack {
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                Text(playlistName)
                    .font(.title)
            }
        }.onAppear(perform: getPlaylist)
    }
    
    private func getPlaylist() {
        Task {
            do {
                let network = Network()
                let playlistRequest = GetCurrentUserPlaylistRequest(limit: 6, offset: 0)
                let playlists: GetCurrentUserPlaylistResponse = try await network.request(playlistRequest)
                let urlString = playlists.items.first!.images.first!.url
                let url = URL(string: urlString)!
                let imageLoader = ImageLoadClient()
                let uiImage = try await imageLoader.getImage(for: url)
                
                await MainActor.run {
                    image = Image(uiImage: uiImage)
                    playlistName = playlists.items.first!.name
                }
            } catch {
                playlistName = error.localizedDescription
            }
        }
    }
}

struct SearchPageView: View {
    var body: some View {
        Text("Search")
    }
}

struct YourLibraryPageView: View {
    var body: some View {
        Text("Your library")
    }
}
