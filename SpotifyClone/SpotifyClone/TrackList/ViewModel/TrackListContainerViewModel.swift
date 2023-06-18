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
    let type: ContainerType
    
    init(imageURL: String,
         type: ContainerType) {
        self.imageURL = imageURL
        self.type = type
    }
    
    func loadTracks() {
        switch type {
        case .album(let album):
            let tracks: [AppTrack] = album.tracks.items.map {
                AppTrack(
                    name: $0.name,
                    uri: $0.uri,
                    artist: AppArtist(name: $0.artists.allArtists(), uri: $0.artists.first?.uri ?? ""),
                    album: AppAlbum(name: album.name, uri: album.uri),
                    context: album.name,
                    contextURI: album.uri,
                    duration: $0.durationMs.toSeconds(),
                    index: $0.trackNumber
                )
            }
            
            let container = AppTrackContainer(
                name: album.name,
                creator: album.artists.allArtists(),
                creatorImage: "",
                image: album.images.first?.url ?? "",
                uri: album.uri,
                tracks: tracks
            )
            
            self.state = .loaded(container)
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
        var index = 1
        let tracks: [AppTrack] = playlist.tracks.items.map {
            let track = AppTrack(
                name: $0.track.name,
                uri: $0.track.uri,
                artist: AppArtist(name: $0.track.artists.allArtists(), uri: $0.track.artists.first?.uri ?? ""),
                album: AppAlbum(name: $0.track.album.name, uri: $0.track.album.uri),
                context: playlist.name,
                contextURI: playlist.uri,
                duration: $0.track.durationMs.toSeconds(),
                index: index
            )
            index += 1
            return track
        }

        return .loaded(
            AppTrackContainer(
                name: playlist.name,
                creator: playlist.owner.displayName ?? "",
                creatorImage: "",
                image: playlist.images.first?.url ?? "",
                uri: playlist.uri,
                tracks: tracks
            )
        )
    }
}

enum TrackListContainerViewState {
    case loading
    case loaded(AppTrackContainer)
}
