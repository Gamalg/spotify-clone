//
//  HomePageViewModel.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 23.05.2023.
//

import Foundation

class HomePageViewModel: ObservableObject {
    // TODO: - Create one model to present the home page
    @Published var playlists: [PlaylistCellViewData] = []
    @Published var albums: [Album] = []

    private let network = AppDIContainer.shared.network

    func getHomePageItems() {
        Task {
            do {
                let playlistRequest = GetCurrentUserPlaylistRequest(limit: 6, offset: 0)
                let playlists: GetCurrentUserPlaylistResponse = try await network.request(playlistRequest)
                
                await MainActor.run {
                    self.playlists = playlists.items.map({ item in
                        PlaylistCellViewData(name: item.name,
                                             imageUrl: item.images.first?.url ?? "",
                                             id: item.id)
                    })
                }
                try await getUsersAlbums()
            } catch {
                
            }
            
        }
    }
    
    private func getUsersAlbums() async throws {
        let savedAlbumRequest = GetUserSavedAlbumsRequest(limit: 10, offest: 0)
        let albumsResponse = try await network.request(savedAlbumRequest)
        await MainActor.run {
            albums = albumsResponse.items.map({ $0.album })
        }
    }
}
