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
    let genres: [String]
    let href: WebAPIEndpointLink
    let id: String
    let images: [RemoteImage]
    let name: String
    let popularity: Int
    let type: String
    let uri: SpotifyURI

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
