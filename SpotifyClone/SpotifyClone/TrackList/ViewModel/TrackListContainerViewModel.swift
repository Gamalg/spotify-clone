//
//  TrackListContainerViewModel.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.06.2023.
//

import Foundation

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
                trackListItems: trackListItems,
                imageURL: ""
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
        
        return .loaded(
            TrackListContainerData(
                name: trackResponse.name,
                creator: "",
                trackListItems: trackListItems,
                imageURL: "")
        )
    }
}

enum TrackListContainerViewState {
    case loading
    case loaded(TrackListContainerData)
}
