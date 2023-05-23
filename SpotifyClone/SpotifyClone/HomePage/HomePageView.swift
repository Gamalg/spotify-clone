//
//  HomePageView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 25.04.2023.
//

import SwiftUI

class HomePageViewModel: ObservableObject {
    @Published var playlists: [PlaylistCellViewData] = []
    @Published var albums: [AlbumHomeGridItemViewData] = []
    @Published var topArtists: [AlbumHomeGridItemViewData] = []
    private let network = AppDIContainer.shared.network
    func getHomePageItems() {
        Task {
            do {
                let playlistRequest = GetCurrentUserPlaylistRequest(limit: 6, offset: 0)
                let playlists: GetCurrentUserPlaylistResponse = try await network.request(playlistRequest)
                
                await MainActor.run {
                    self.playlists = playlists.items.map({ item in
                        PlaylistCellViewData(name: item.name, imageUrl: item.images.first?.url ?? "")
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
            albums = albumsResponse.items.map({ .init(album: $0.album) })
        }
    }
    
    private func getTopItems() async throws {
        let topArtistsRequest = GetUserTopArtistsRequest(limit: 10, offset: 0, timeRange: .short)
        let response = try await network.request(topArtistsRequest)
        await MainActor.run {
            topArtists = response.items.map({
                .init(name: $0.name, artistName: $0.type, coverImageURL: $0.images.first?.url ?? "")
            })
        }
    }
}

struct HomePageView: View {
    @StateObject var viewModel = HomePageViewModel()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Good day")
                Text("Your playlist:")
                GridView(data: viewModel.playlists,
                         direction: .vertical([GridItem(.flexible()), GridItem(.flexible())])) { playlist in
                    PlaylistCellView(playlist: playlist)
                }
                Text("Your top artists")
                GridView(data: viewModel.topArtists,
                         direction: .horizontal([GridItem(.flexible())])) { album in
                    AlbumHomeGridItemView(album: album)
                }
                
                GridView(data: viewModel.albums,
                         direction: .horizontal([GridItem(.flexible())])) { album in
                    AlbumHomeGridItemView(album: album)
                }
            }
            .onAppear { viewModel.getHomePageItems() }
        }
    } 
}

struct PlaylistTracksResponse: Codable {
    let href: String
    let items: [PlaylistTrackItem]
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    
    struct PlaylistTrackItem: Codable {
        let addedAt: String
        let addedBy: AddedBy?
        let isLocal: Bool
        let track: Track
        
        struct AddedBy: Codable {
            let externalUrls: [String: String]
            let href: String?
            let id: String
            let type: String
            let uri: String
        }
        
        struct Track: Codable {
            let album: Album
            let artists: [Artist]
            let availableMarkets: [String]
            let discNumber: Int
            let durationMs: Int
            let explicit: Bool
            let externalIds: [String: String]
            let externalUrls: [String: String]
            let href: String
            let id: String
            let isLocal: Bool
            let name: String
            let popularity: Int
            let previewUrl: String?
            let trackNumber: Int
            let type: String
            let uri: String
            
            struct Album: Codable {
                let albumType: String
                let artists: [Artist]
                let availableMarkets: [String]
                let externalUrls: [String: String]
                let href: String
                let id: String
                let images: [Image]
                let name: String
                let releaseDate: String
                let releaseDatePrecision: String
                let totalTracks: Int
                let type: String
                let uri: String
                
                struct Artist: Codable {
                    let externalUrls: [String: String]
                    let href: String
                    let id: String
                    let name: String
                    let type: String
                    let uri: String
                }
                
                struct Image: Codable {
                    let height: Int?
                    let url: String
                    let width: Int?
                }
            }
            
            struct Artist: Codable {
                let externalUrls: [String: String]
                let href: String
                let id: String
                let name: String
                let type: String
                let uri: String
            }
        }
    }
}

struct PlaylistTracksRequest: Codable {
    let id: String
    let fields: String?
    let limit: Int?
    let market: String?
    let offset: Int?
    let additionalTypes: String?
}
