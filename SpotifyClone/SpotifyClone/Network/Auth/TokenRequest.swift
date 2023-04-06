//
//  TokenRequest.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 05.04.2023.
//

import Foundation

struct Token: Decodable {
    let accessToken: String
}

struct TokenRequestBody: HTTPBodyEncodable {
    let grantType: String = "authorization_code"
    let code: String
    let redirectUri: String
    let clientId: String
    let codeVerifier: String
}

struct TokenRequest: Request {
    var path: String = "/api/token"
    var parameters: [String: Any]
    var body: HTTPBodyEncodable?
    var headers: [String: String] = [:]
    var method: HTTPMethod = .POST
    
    init(code: String, codeVerifier: String, redirectUri: String) {
        parameters = [
            "code": code,
            "redirect_uri": "g-spotify://g-spotify-callback",
            "client_id": "d5266d28457741dc81d9b8172ff32bd5",
            "grant_type": "authorization_code",
            "code_verifier": codeVerifier
        ]
        self.body = TokenRequestBody(code: code, redirectUri: redirectUri, clientId: "d5266d28457741dc81d9b8172ff32bd5", codeVerifier: codeVerifier)
    }
}
