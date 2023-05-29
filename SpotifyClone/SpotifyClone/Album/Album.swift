//
//  Album.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 16.05.2023.
//

import Foundation

struct SavedAlbumResponse: Hashable, Decodable {
    let href: String
    let items: [SavedAlbum]
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
}

struct SavedAlbum: Hashable, Decodable {
    let addedAt: String
    let album: Album
}

struct Album: Hashable, Decodable {
    let albumType: String
    let artists: [AlbumArtist]
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [Album.Image]
    let name: String
    let releaseDate: String
    let releaseDatePrecision: String
    let totalTracks: Int
    let type: String
    let uri: String
    let tracks: AlbumTracks
    
    struct Image: Hashable, Decodable {
        let height: Int?
        let url: String
        let width: Int?
    }
}

struct AlbumTracks: Hashable, Decodable {
    let href: String
    let limit: Int
    /// url to the next page
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    let items: [SimplifiedTrack]
}

struct SimplifiedTrack: Hashable, Decodable {
    let artists: [SimplfiedArtist]
    let availableMarkets: [String]?
    let discNumber: Int
    let durationMs: Int
    let explicit: Bool
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    /// Part of the response when Track Relinking is applied. If true, the track is playable in the given market. Otherwise false.
    let isPlayable: Bool
    let linkedFrom: LinkedFrom?
    let restrictions: Restrictions?
    let name: String

    /**
     A URL to a 30 second preview (MP3 format) of the
     
     Important policy note
     Spotify Audio preview clips can not be a standalone service
     Audio Preview Clips may not be offered as a standalone service or product.

     More information: https://developer.spotify.com/policy#ii-respect-content-and-creators
     */
    let previewUrl: String
    
    /// The number of the track. If an album has several discs, the track number is the number on the specified disc.
    let trackNumber: Int
    
    /// The object type: "track".
    let type: String
    let uri: String
    
    ///Whether or not the track is from a local file.
    let isLocal: Bool
}

/**
 Part of the response when Track Relinking is applied and is only part of the response if the track linking, in fact, exists.
 The requested track has been replaced with a different track.
 The track in the linked_from object contains information about the originally requested track.
 */
struct LinkedFrom: Hashable, Decodable {
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    /// The object type: "track".
    let type: String
    let uri: String
}

/// Included in the response when a content restriction is applied.
struct Restrictions: Hashable, Decodable {
    /**
     The reason for the restriction. Supported values:

     market - The content item is not available in the given market.
     product - The content item is not available for the user's subscription type.
     explicit - The content item is explicit and the user's account is set to not play explicit content.
     Additional reasons may be added in the future. Note: If you use this field, make sure that your application safely handles unknown values.
     */
    let reason: String
}

struct SimplfiedArtist: Hashable, Decodable {
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let name: String
    /// Allowed values: "artist"
    let type: String
    let uri: String
}

struct AlbumArtist: Hashable, Decodable {
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let name: String
    let type: String
    let uri: String
}

struct ExternalUrls: Hashable, Decodable {
    var spotify: String?
}

extension Array where Element == Artist {
    func allArtists() -> String {
        map { $0.name }.joined(separator: ",")
    }
}

extension Array where Element == SimplfiedArtist {
    func allArtists() -> String {
        map { $0.name }.joined(separator: ",")
    }
}

extension Array where Element == AlbumArtist {
    func allArtists() -> String {
        map { $0.name }.joined(separator: ",")
    }
}
