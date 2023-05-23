//
//  Artist.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 16.05.2023.
//

import Foundation

struct Artist: Decodable {
    let externalUrls: ExternalUrls
    let followers: Followers
    let genres: [String]
    let href: String
    let id: String
    let images: [Image]
    let name: String
    let popularity: Int
    let type: String
    let uri: String
    
    struct ExternalUrls: Decodable {
        let spotify: String
    }

    struct Followers: Decodable {
        let href: String?
        let total: Int
    }

    struct Image: Decodable {
        let height: Int?
        let url: String
        let width: Int?
    }
}
