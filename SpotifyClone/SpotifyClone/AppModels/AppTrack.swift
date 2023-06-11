//
//  AppTrack.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 07.06.2023.
//

import Foundation
import SpotifyiOS

struct AppTrack {
    var name: String
    var uri: SpotifyURI
    var artistName: String
    var artistURI: SpotifyURI
    var albumName: String
    var albumURI: SpotifyURI
    var context: String
    var contextURI: SpotifyURI
    
    /// In seconds
    var duration: UInt
}

extension AppTrack {
    init(track: Track) {
        self.name = track.name
        self.artistName = track.artists.allArtists()
        self.uri = track.uri
        self.albumName = track.album.name
        self.albumURI = track.album.uri
        self.artistURI = track.artists.first?.uri ?? ""
        self.duration = track.durationMs.toSeconds()
        self.context = track.album.name
        self.contextURI = track.album.uri
    }
}

extension AppTrack {
    init(playerState: SPTAppRemotePlayerState) {
        self.name = playerState.track.name
        self.uri = playerState.track.uri
        self.artistName = playerState.track.artist.name
        self.artistURI = playerState.track.artist.uri
        self.albumName = playerState.track.album.name
        self.albumURI = playerState.track.album.uri
        self.context = playerState.contextTitle
        self.contextURI = playerState.contextURI.absoluteString
        self.duration = playerState.track.duration.toSeconds()
    }
}
