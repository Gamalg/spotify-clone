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
    @State var id = ""
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
                    .onTapGesture {
                        getSongs(id: self.id)
                    }
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
                    id = playlists.items.first!.id
                }
            } catch {
                playlistName = error.localizedDescription
            }
        }
    }
    
    private func getSongs(id: String) {
        Task {
            do {
                
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
