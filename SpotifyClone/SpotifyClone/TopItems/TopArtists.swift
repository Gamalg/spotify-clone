//
//  TopArtists.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 17.05.2023.
//

import Foundation

struct TopArtistsResponse: Decodable {
    let items: [ArtistItem]
}

struct ArtistItem: Decodable {
    let externalUrls: ExternalUrls
    let followers: ArtistItem.Followers
    let genres: [String]
    let href: WebAPIEndpointLink
    let id: String
    let images: [RemoteImage]
    let name: String
    let popularity: Int
    let type: String
    let uri: SpotifyURI

    struct Followers: Codable {
        let href: WebAPIEndpointLink?
        let total: Int
    }

    struct Image: Codable {
        let height: Int?
        let url: String
        let width: Int?
    }
}
