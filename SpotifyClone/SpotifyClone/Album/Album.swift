//
//  Album.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 16.05.2023.
//

import Foundation

struct SavedAlbumResponse: Decodable {
    let href: String
    let items: [AlbumItem]
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
}

struct AlbumItem: Decodable {
    let addedAt: String
    let album: Album
}

struct Album: Decodable {
    let albumType: String
    let artists: [Album.Artist]
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [Image]
    let name: String
    let releaseDate: String
    let releaseDatePrecision: String
    let totalTracks: Int
    let type: String
    let uri: String
    
    struct Artist: Decodable {
        let name: String
    }
    
    struct ExternalUrls: Decodable {
        let spotify: String
    }

    struct Image: Decodable {
        let height: Int?
        let url: String
        let width: Int?
    }
}
