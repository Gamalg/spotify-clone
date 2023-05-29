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
    @Published var topArtists: [AlbumHomeGridItemViewData] = []

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
                                             href: item.href)
                    })
                }
                try await getUsersAlbums()
                try await getTopItems()
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
    
    private func getTopItems() async throws {
        let topArtistsRequest = GetUserTopArtistsRequest(limit: 10, offset: 0, timeRange: .short)
        let response = try await network.request(topArtistsRequest)
        await MainActor.run {
            topArtists = response.items.map({
                .init(name: $0.name, artistName: $0.type, coverImageURL: $0.images.first?.url ?? "", href: $0.href)
            })
        }
    }
}
