//
//  Album.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 16.05.2023.
//

import Foundation

struct SavedAlbumResponse: Hashable, Decodable {
    let href: WebAPIEndpointLink
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
    let href: WebAPIEndpointLink
    let id: String
    let images: [RemoteImage]
    let name: String
    let releaseDate: String
    let releaseDatePrecision: String
    let totalTracks: Int
    let type: String
    let uri: SpotifyURI
    let tracks: AlbumTracks
}

struct AlbumTracks: Hashable, Decodable {
    let href: WebAPIEndpointLink
    let limit: Int
    /// url to the next page
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    let items: [SimplifiedTrack]
}

struct AlbumArtist: Hashable, Decodable {
    let externalUrls: ExternalUrls
    let href: WebAPIEndpointLink
    let id: String
    let name: String
    let type: String
    let uri: SpotifyURI
}

struct ExternalUrls: Hashable, Decodable {
    var spotify: String?
}

extension Array where Element == Artist {
    /// - Parameter separator: "," by default
    func allArtists(separator: String = ",") -> String {
        map { $0.name }.joined(separator: separator)
    }
}

extension Array where Element == SimplfiedArtist {
    /// - Parameter separator: "," by default
    func allArtists(separator: String = ",") -> String {
        map { $0.name }.joined(separator: separator)
    }
}

extension Array where Element == AlbumArtist {
    /// - Parameter separator: "," by default
    func allArtists(separator: String = ",") -> String {
        map { $0.name }.joined(separator: separator)
    }
}
