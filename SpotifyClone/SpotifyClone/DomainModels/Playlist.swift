//
//  Playlist.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 26.04.2023.
//

import Foundation

struct Playlist: Decodable {
    /// true if the owner allows other users to modify the playlist
    let collaborative: Bool
    
    /// The playlist description. Only returned for modified, verified playlists, otherwise null
    let description: String?
    let externalUrls: ExternalUrls
    let href: WebAPIEndpointLink
    let id: SpotifyID
    let images: [RemoteImage]
    let name: String
    let owner: Owner
    
    /// The version identifier for the current playlist. Can be supplied in other requests to target a specific playlist version
    let snapshotId: String
    let tracks: Tracks
    let type: String
    let uri: SpotifyURI
    let primaryColor: String?
    
    struct Owner: Decodable {
        let externalUrls: ExternalUrls
        let href: WebAPIEndpointLink
        let id: SpotifyID
        
        /// The object type.
        /// Allowed values: "user"
        let type: String
        let uri: SpotifyURI
        
        /// The name displayed on the user's profile. null if not available
        let displayName: String?
    }
    
    struct Tracks: Decodable {
        let href: WebAPIEndpointLink
        let limit: Int
        let next: String?
        let offset: Int
        let previous: String?
        let total: Int
        let items: [PlaylistTrack]
    }
    
    struct Followers: Decodable {
        let href: WebAPIEndpointLink?
        let total: Int
    }
    
    struct PlaylistTrack: Decodable {
        /// The Spotify user who added the track or episode.
        /// Note: some very old playlists may return null in this field.
        struct AddedBy: Decodable {
            let externalUrls: ExternalUrls
            let href: WebAPIEndpointLink
            let id: SpotifyUserID
            
            /// The object type. Allowed values: "user"
            let type: String
            let uri: SpotifyURI
        }
        
        struct Track: Decodable {
            struct PlaylistTrackAlbum: Decodable {
                let albumType: String
                let artists: [AlbumArtist]
                let externalUrls: ExternalUrls
                let href: WebAPIEndpointLink
                let id: String
                let images: [RemoteImage]
                let name: String
                let releaseDate: String
                let releaseDatePrecision: String
                let totalTracks: Int
                let type: String
                let uri: SpotifyURI
            }
            
            let album: PlaylistTrackAlbum
            let artists: [SimplfiedArtist]
            let discNumber: Int
            
            /// The track length in milliseconds.
            let durationMs: Milliseconds
            let explicit: Bool
            let externalUrls: ExternalUrls
            let href: WebAPIEndpointLink
            let id: SpotifyID
            
            /// Part of the response when Track Relinking is applied. If true, the track is playable in the given market. Otherwise false.
            let isPlayable: Bool
            let name: String
            
            /**
             The popularity of the track. The value will be between 0 and 100, with 100 being the most popular.
             The popularity of a track is a value between 0 and 100, with 100 being the most popular.
             The popularity is calculated by algorithm and is based, in the most part, on the total number of plays the track has had and how recent those plays are.
             Generally speaking, songs that are being played a lot now will have a higher popularity than songs that were played a lot in the past.
             Duplicate tracks (e.g. the same track from a single and an album) are rated independently.
             Artist and album popularity is derived mathematically from track popularity.
             
             Note: the popularity value may lag actual popularity by a few days: the value is not updated in real time.
             */
            let popularity: Int
            
            /// The object type: "track".
            /// Allowed values: "track"
            let type: String
            let uri: SpotifyURI
            let isLocal: Bool
        }
        
        /// The date and time the track or episode was added.
        /// Note: some very old playlists may return null in this field.
        let addedAt: String?
        
        /// The Spotify user who added the track or episode.
        /// Note: some very old playlists may return null in this field.
        let addedBy: AddedBy?
        
        /// Whether this track or episode is a local file or not.
        let isLocal: Bool
        
        let track: PlaylistTrack.Track
    }
}
