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
        case playlist(SpotifyID)
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
                ownerName: album.artists.allArtists(separator: "•"),
                trackListItems: trackListItems,
                ownerImageURL: ""
            )
            
            self.state = .loaded(trackListContainerData)
        case .playlist(let playlistID):
            fetchPlaylist(playlistID)
        }
    }
    
    private func fetchPlaylist(_ playlistID: SpotifyID) {
        Task {
            do {
                let getPlaylistRequest = GetPlaylistRequest(playlistID: playlistID)
                let playlist: Playlist = try await network.request(getPlaylistRequest)
                await MainActor.run {
                    state = fromTrackResponseToState(playlist)
                }
            } catch {
                // error handling
            }
        }
    }
    
    private func fromTrackResponseToState(_ playlist: Playlist) -> TrackListContainerViewState {
        let trackListItems = playlist.tracks.items.map {
            TrackListItem(name: $0.track.name,
                          authorName: $0.track.artists.map { $0.name }.joined(separator: ","),
                          spotifyURI: $0.track.uri,
                          durationInSeconds: Double($0.track.durationMs / 1000))
        }

        return .loaded(
            TrackListContainerData(
                name: playlist.name,
                ownerName: playlist.owner.displayName ?? "",
                trackListItems: trackListItems,
                ownerImageURL: "")
        )
    }
}

enum TrackListContainerViewState {
    case loading
    case loaded(TrackListContainerData)
}
