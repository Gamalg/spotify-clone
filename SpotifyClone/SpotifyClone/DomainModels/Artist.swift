//
//  Artist.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 16.05.2023.
//

import Foundation

struct Artist: Decodable {
    let externalUrls: ExternalUrls
    let followers: Followers?
    let images: [RemoteImage]
    let popularity: Int
    let href: WebAPIEndpointLink
    let uri: SpotifyURI
    let id: String
    let name: String
    let type: String
    let genres: [String]

    struct Followers: Decodable {
        let href: WebAPIEndpointLink?
        let total: Int
    }
}

struct SimplfiedArtist: Hashable, Decodable {
    let externalUrls: ExternalUrls
    let href: WebAPIEndpointLink
    let id: String
    let name: String
    /// Allowed values: "artist"
    let type: String
    let uri: SpotifyURI
}
