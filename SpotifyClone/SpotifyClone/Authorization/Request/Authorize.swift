//
//  Authorize.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 06.04.2023.
//

import Foundation

struct AuthorizeResponse: Decodable {
}

struct AuthorizeRequest: Request {
    var headers: [String : String] = [:]
    var path: String = "/authorize"
    var method: HTTPMethod = .GET
    var parameters: [String : Any]
    var neededAuth: Bool = false
    
    init(state: String, codeChallenge: String) {
        parameters = [
            "client_id": GlobalConstants.spotifyClientID,
            "response_type": "code",
            "redirect_uri": GlobalConstants.redirectURI,
            "state": state,
            "scope": "user-read-private user-read-email",
            "code_challenge_method": "S256",
            "code_challenge": codeChallenge
        ]
    }
}
