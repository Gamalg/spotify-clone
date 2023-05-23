//
//  GetCurrentUserPlaylistRequest.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 26.04.2023.
//

import Foundation

struct GetCurrentUserPlaylistRequest: Request {
    typealias ResponseType = GetCurrentUserPlaylistResponse
    
    var path: String = "/v1/me/playlists"
    var parameters: [String : Any]
    var headers: [String : String] = [:]
    var method: HTTPMethod = .GET
    
    var neededAuth: Bool = true
    
    init(limit: Int, offset: Int) {
        parameters = [
            "limit": limit,
            "offset": offset
        ]
    }
}

struct GetCurrentUserPlaylistResponse: Decodable {
    let limit: Int
    let total: Int
    
    /// A link to the Web API endpoint returning the full result of the request
    let href: String
    /// URL to the next page of items
    let next: String?
    /// URL to the previous page of items
    let previous: String?
    
    let items: [Playlist]
}
