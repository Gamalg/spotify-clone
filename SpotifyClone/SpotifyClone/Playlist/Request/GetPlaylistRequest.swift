//
//  GetPlaylistRequest.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.06.2023.
//

import Foundation

struct GetPlaylistRequest: Request {
    typealias ResponseType = Playlist
    
    var path: String
    var parameters: [String : Any]
    var headers: [String : String] = [:]
    var method: HTTPMethod = .GET
    var neededAuth: Bool = true
    
    init(playlistID: SpotifyID, market: String = "KZ") {
        path = "/v1/playlists/\(playlistID)"
        parameters = [
            "market": market
        ]
    }
}
