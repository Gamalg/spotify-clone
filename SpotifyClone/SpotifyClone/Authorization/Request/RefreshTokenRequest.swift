//
//  RefreshTokenRequest.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 23.04.2023.
//

import Foundation

struct RefreshTokenRequest: Request {
    typealias ResponseType = TokenRequestResponse
    
    var path: String = "/api/token"
    var parameters: [String: Any]
    var headers: [String: String] = [:]
    var method: HTTPMethod = .POST
    var neededAuth: Bool = false
    
    init(refreshToken: String) {
        parameters = [
            "refresh_token": refreshToken,
            "redirect_uri": GlobalConstants.redirectURI,
            "client_id": GlobalConstants.spotifyClientID,
            "grant_type": "refresh_token"
        ]
    }
}
