//
//  TokenRequest.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 05.04.2023.
//

import Foundation
import CoreFoundation

struct Token: Decodable {
    let accessToken: String
    let tokenType: String
    let expiresIn: TimeInterval
    let refreshToken: String
    let scope: String
}

struct TokenRequest: Request {
    var path: String = "/api/token"
    var parameters: [String: Any]
    var headers: [String: String] = [:]
    var method: HTTPMethod = .POST
    
    init(code: String, codeVerifier: String, redirectUri: String) {
        parameters = [
            "code": code,
            "redirect_uri": GlobalConstants.redirectURI,
            "client_id": GlobalConstants.spotifyClientID,
            "grant_type": "authorization_code",
            "code_verifier": codeVerifier
        ]
    }
}
