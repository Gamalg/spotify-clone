//
//  TrackListContainerView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 20.05.2023.
//

import SwiftUI

fileprivate struct ControlPanelView: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
            }.padding(.trailing)
            Button(action: {}) {
                Image(systemName: "arrow.down.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
            }.padding(.trailing)
            Button(action: {}) {
                Image(systemName: "ellipsis")
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "shuffle")
                    .resizable()
                    .frame(width: 25, height: 20)
            }
            .padding(.trailing)
            Button(action: {}) {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 44, height: 44)
            }
        }
    }
}

fileprivate struct AuthorView: View {
    let authorName: String
    var body: some View {
        // Author, or created by spotify for ...
        HStack {
            Image(systemName: "music.note.list")
            Text(authorName)
        }
    }
}

fileprivate struct TrackListItemView: View {
    let trackListItem: TrackListItem
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(trackListItem.name)
                Text(trackListItem.authorName)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "ellipsis")
            }
        }
    }
}

/**
 Needed data:
 - Name of container
 - Creator name
 - Array of tracks with song name, author, spotify track id
 */

struct TrackListItem: Identifiable {
    let name: String
    let authorName: String
    let spotifyURI: String
    let durationInSeconds: Double
    
    var id: String {
        spotifyURI
    }
}

struct TrackListContainerData {
    let name: String
    let creator: String
    let trackListItems: [TrackListItem]
}

class TrackListContainerViewModel: ObservableObject {
    enum ContainerType {
        /// Required URL string
        case playlist(String)
        case album(Album)
    }
    
    @Published var state: TrackListContainerViewState = .loading
    let imageURL: String
    private let network = AppDIContainer.shared.network
    private let type: ContainerType
    
    init(imageURL: String,
         type: ContainerType) {
        self.imageURL = imageURL
        self.type = type
    }
    
    func loadTracks() {
        switch type {
        case .album(let album):
            let trackListItems: [TrackListItem] = album.tracks.items.map {
                TrackListItem(name: $0.name, authorName: $0.artists.allArtists(), spotifyURI: $0.uri, durationInSeconds: Double($0.durationMs / 1000))
            }
            
            let trackListContainerData = TrackListContainerData(
                name: album.name,
                creator: album.artists.allArtists(),
                trackListItems: trackListItems
            )
            
            self.state = .loaded(trackListContainerData)
        case .playlist(let urlString):
            guard let url = URL(string: urlString) else {
                print("Invalid URL for playlist: \(urlString)")
                return
            }

            fetchPlaylist(url)
        }
    }
    
    private func fetchPlaylist(_ url: URL) {
        Task {
            do {
                let tracks: PlaylistTracksResponse = try await network.request(url: url)
                await MainActor.run {
                    state = fromTrackResponseToState(tracks)
                }
            } catch {
                // error handling
            }
        }
    }
    
    private func fromTrackResponseToState(_ trackResponse: PlaylistTracksResponse) -> TrackListContainerViewState {
        let trackListItems = trackResponse.tracks.items.map {
            TrackListItem(name: $0.track.name,
                          authorName: $0.track.artists.map { $0.name }.joined(separator: ","),
                          spotifyURI: $0.track.uri,
                          durationInSeconds: Double($0.track.durationMs / 1000))
        }
        
        return .loaded(TrackListContainerData(name: trackResponse.name, creator: "Hey", trackListItems: trackListItems))
    }
}

enum TrackListContainerViewState {
    case loading
    case loaded(TrackListContainerData)
}

struct TrackListContainerView: View {
    @ObservedObject var viewModel: TrackListContainerViewModel
    @EnvironmentObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        // TODO: - Add gradient background
        ScrollView(showsIndicators: false) {
            VStack {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .loaded(let containerData):
                    // Image for Track list
                    //            Image("")
                    AsyncCachedImage(url: viewModel.imageURL, placeholder: .playlist)
                        .frame(width: 300, height: 300)
                    VStack(alignment: .leading) {
                        // Name of list
                        // Album name, mix name, or playlist name
                        Text(containerData.name)
                            .padding(.bottom)
                        
                        AuthorView(authorName: containerData.creator)
                            .padding(.bottom)
                        ControlPanelView()
                            .padding(.bottom)
                        
                        ForEach(containerData.trackListItems) { trackListItem in
                            TrackListItemView(trackListItem: trackListItem)
                                .padding(.bottom)
                                .onTapGesture {
                                    playerViewModel.playTrackListItem(trackListItem)
                                }
                        }
                    }.padding()
                }
            }.onAppear(perform: viewModel.loadTracks)
        }
    }
}

struct TrackListView_Previews: PreviewProvider {
    static var previews: some View {
        TrackListContainerView(viewModel: .init(imageURL: "", type: .playlist("")))
    }
}
