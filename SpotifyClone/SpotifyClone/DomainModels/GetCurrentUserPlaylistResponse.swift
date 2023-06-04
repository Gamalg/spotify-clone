//
//  GetCurrentUserPlaylistResponse.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.06.2023.
//

import Foundation

struct GetCurrentUserPlaylistResponse: Decodable {
    let limit: Int
    let total: Int
    
    /// A link to the Web API endpoint returning the full result of the request
    let href: WebAPIEndpointLink
    /// URL to the next page of items
    let next: String?
    /// URL to the previous page of items
    let previous: String?
    
    let items: [SimplifiedPlaylist]
}

struct SimplifiedPlaylist: Decodable {
    struct SimplifiedPlaylistTracks: Decodable {
        let href: WebAPIEndpointLink
        let total: Int
    }
    
    /// true if the owner allows other users to modify the playlist
    let collaborative: Bool
    
    /// The playlist description. Only returned for modified, verified playlists, otherwise null.
    let description: String?
    let externalUrls: ExternalUrls
    let href: WebAPIEndpointLink
    let id: SpotifyID
    let images: [RemoteImage]
    let name: String
    let owner: Playlist.Owner
    let `public`: Bool
    let tracks: SimplifiedPlaylistTracks
    
    /// The object type: "playlist"
    let type: String
    
    let uri: SpotifyURI
}
