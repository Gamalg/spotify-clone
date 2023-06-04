//
//  Track.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.06.2023.
//

import Foundation

struct Track: Decodable {
    let album: Album
    let artists: [Artist]
    let availableMarkets: [String]
    let discNumber: Int
    
    /// The track length in milliseconds.
    let durationMs: Int
    let explicit: Bool
    let externalUrls: ExternalUrls
    let href: WebAPIEndpointLink
    let id: SpotifyID
    
    /// Part of the response when Track Relinking is applied. If true, the track is playable in the given market. Otherwise false.
    let isPlayable: Bool
    let restrictions: Restrictions
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

struct SimplifiedTrack: Hashable, Decodable {
    let artists: [SimplfiedArtist]
    let availableMarkets: [String]?
    let discNumber: Int
    let durationMs: Int
    let explicit: Bool
    let externalUrls: ExternalUrls
    let href: WebAPIEndpointLink
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
    let uri: SpotifyURI
    
    ///Whether or not the track is from a local file.
    let isLocal: Bool
}
