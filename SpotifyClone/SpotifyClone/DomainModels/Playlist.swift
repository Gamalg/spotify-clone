//
//  Playlist.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 26.04.2023.
//

import Foundation

struct Playlist: Decodable {
    let collaborative: Bool
    let description: String
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [Image]
    let name: String
    let owner: Owner
    let snapshotId: String
    let tracks: Tracks
    let type, uri: String
    let primaryColor: String?
    
    struct Image: Decodable {
        let url: String
        let height: Int?
        let width: Int?
    }
    
    struct ExternalUrls: Decodable {
        let spotify: String
    }
    
    struct Owner: Decodable {
        let externalUrls: ExternalUrls
        let href: String
        let id, type, uri, displayName: String
    }
    
    struct Tracks: Decodable {
        let href: String
        let total: Int
    }
}
