//
//  TokenRequest.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 05.04.2023.
//

import Foundation
import CoreFoundation

struct Token: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: TimeInterval
    let refreshToken: String
    let scope: String
    let expiresDate: Date
    var hasTokenExpired: Bool {
        Date() < expiresDate
    }
}

struct TokenDTO: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: TimeInterval
    let refreshToken: String
    let scope: String
    
    func toDomain() -> Token {
        let fiveMinutesInSeconds: TimeInterval = 60 * 5
        return Token(accessToken: accessToken,
                     tokenType: tokenType,
                     expiresIn: expiresIn,
                     refreshToken: refreshToken,
                     scope: scope,
                     expiresDate: Date().addingTimeInterval(expiresIn - fiveMinutesInSeconds))
    }
}

struct TokenRequest: Request {
    var path: String = "/api/token"
    var parameters: [String: Any]
    var headers: [String: String] = [:]
    var method: HTTPMethod = .POST
    var neededAuth: Bool = false
    
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
