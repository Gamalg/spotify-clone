//
//  TopArtists.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 17.05.2023.
//

import Foundation

struct TopArtistsResponse: Codable {
    let items: [ArtistItem]
}

struct ArtistItem: Codable {
    let externalUrls: ArtistItem.ExternalUrls
    let followers: ArtistItem.Followers
    let genres: [String]
    let href: String
    let id: String
    let images: [ArtistItem.Image]
    let name: String
    let popularity: Int
    let type: String
    let uri: String
    
    struct ExternalUrls: Codable {
        let spotify: String
    }

    struct Followers: Codable {
        let href: String?
        let total: Int
    }

    struct Image: Codable {
        let height: Int?
        let url: String
        let width: Int?
    }
}
