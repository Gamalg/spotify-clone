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
                        HomePageHeadlineText(text: "Good day")
                        HomePageHeadlineText(text: "Your playlist:")
                        GridView(data: viewModel.playlists,
                                 direction: .vertical([GridItem(.flexible()), GridItem(.flexible())])) { playlist in
                            NavigationLink {
                                TrackListContainerView(
                                    viewModel: .init(imageURL: playlist.imageUrl, type: .playlist(playlist.id))
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
                                HomeCollectionGridItemView(viewData: .init(album: album))
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
