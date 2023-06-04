//
//  CurrentUsersPlaylist.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.06.2023.
//

import Foundation

struct GetCurrentUserPlaylistResponse: Decodable {
    let limit: Int
    let total: Int
    
    /// A link to the Web API endpoint returning the full result of the request
    let href: String
    /// URL to the next page of items
    let next: String?
    /// URL to the previous page of items
    let previous: String?
    
    let items: [SimplifiedPlaylist]
}

struct SimplifiedPlaylist: Decodable {
    
}
