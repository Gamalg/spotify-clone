//
//  HomePageView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 25.04.2023.
//

import SwiftUI

struct HomePageView: View {
    @StateObject var viewModel = HomePageViewModel()
    var body: some View {
        NavigationView {
            BlackBGScreen {
                // Grid view made of grid views
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text("Good day")
                        Text("Your playlist:")
                        GridView(data: viewModel.playlists,
                                 direction: .vertical([GridItem(.flexible()), GridItem(.flexible())])) { playlist in
                            NavigationLink {
                                TrackListContainerView(
                                    viewModel: .init(imageURL: playlist.imageUrl, type: .playlist(playlist.href))
                                )
                            } label: {
                                PlaylistCellView(playlist: playlist)
                            }
                        }
                        GridView(data: viewModel.albums,
                                 direction: .horizontal([GridItem(.flexible())])) { album in
                            NavigationLink {
                                TrackListContainerView(
                                    viewModel: .init(imageURL: album.images.first?.url ?? "", type: .album(album))
                                )
                            } label: {
                                AlbumHomeGridItemView(album: AlbumHomeGridItemViewData(album: album))
                            }
                        }
                        
                        // TODO: - Feauture: Recently played
                        
                        // TODO: - Feauture: Recommendations
                        
                        // TODO: - Feauture: Related artists (related to random top artists)
                        
                        // TODO: - Feauture: New release
                    }
                    .padding()
                    .onAppear { viewModel.getHomePageItems() }
                }
            }
        }
    }
}

struct PlaylistTracksResponse: Codable {
    let name: String
    let tracks: PlaylistTracksResponse.Tracks
    
    struct Tracks: Codable {
        struct TrackItem: Codable {
            struct Track: Codable {
                let name: String
                let durationMs: Int
                let uri: String
                let artists: [PlaylistTracksResponse.Tracks.TrackItem.Track.Artist]
                struct Artist: Codable {
                    let name: String
                }
            }
            
            let track: PlaylistTracksResponse.Tracks.TrackItem.Track
        }
        
        let items: [PlaylistTracksResponse.Tracks.TrackItem]
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
