//
//  AppTrack.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 07.06.2023.
//

import Foundation
import SpotifyiOS

struct AppArtist {
    let name: String
    let uri: SpotifyURI
}

struct AppAlbum {
    let name: String
    let uri: SpotifyURI
}

class AppTrack: NSObject, Identifiable {
    var id: SpotifyURI {
        uri
    }

    let name: String
    let uri: SpotifyURI
    let artist: AppArtist
    let album: AppAlbum
    let context: String
    let contextURI: SpotifyURI
    
    /// In seconds
    let duration: UInt
    let index: Int
    
    init(name: String, uri: SpotifyURI, artist: AppArtist, album: AppAlbum, context: String, contextURI: SpotifyURI, duration: UInt, index: Int) {
        self.name = name
        self.uri = uri
        self.artist = artist
        self.album = album
        self.context = context
        self.contextURI = contextURI
        self.duration = duration
        self.index = index
    }
}

extension AppTrack: SPTAppRemoteContentItem {
    var title: String? {
        name
    }
    
    var subtitle: String? {
        artist.name
    }
    
    var identifier: String {
        "\(uri)?contextURI=\(contextURI)"
    }
    
    var isAvailableOffline: Bool {
        false
    }
    
    var isPlayable: Bool {
        true
    }
    
    var isContainer: Bool {
        false
    }
    
    var children: [SPTAppRemoteContentItem]? {
        nil
    }
    
    var imageIdentifier: String {
        ""
    }
}

extension AppTrack {
    convenience init(track: Track) {
        self.init(
            name: track.name,
            uri: track.uri,
            artist: AppArtist(name: track.artists.allArtists(), uri: track.artists.first?.uri ?? ""),
            album: AppAlbum(name: track.name, uri: track.uri),
            context: track.album.name,
            contextURI: track.album.uri,
            duration: track.durationMs.toSeconds(),
            index: track.trackNumber()
        )
    }
}

extension AppTrack {
    convenience init(playerState: SPTAppRemotePlayerState) {
        self.init(
            name: playerState.track.name,
            uri: playerState.track.uri,
            artist: AppArtist(name: playerState.track.artist.name, uri: playerState.track.uri),
            album: AppAlbum(name: playerState.track.album.name, uri: playerState.track.album.uri),
            context: playerState.contextTitle,
            contextURI: playerState.contextURI.absoluteString,
            duration: playerState.track.duration.toSeconds(),
            index: 0
        )
    }
}
