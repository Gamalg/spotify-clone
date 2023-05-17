//
//  GetUserSavedAlbumsRequest.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 16.05.2023.
//

import Foundation

struct GetUserSavedAlbumsRequest: Request {
    typealias ResponseType = SavedAlbumResponse
    
    var path: String = "/v1/me/albums"
    var parameters: [String : Any]
    var headers: [String: String] = [:]
    var method: HTTPMethod = .GET
    var neededAuth: Bool = true
    
    init(limit: Int, offest: Int, market: String = "KZ") {
        parameters = [
            "limit": limit,
            "offset": offest,
            "market": market
        ]
    }
}
