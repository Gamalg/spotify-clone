//
//  TokenIdentityClient.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 20.04.2023.
//

import Foundation

protocol TokenIdentityClientProtocol {
    @discardableResult
    func getToken(code: String, codeVerifier: String, redirectUri: URL) async throws -> Token
    
    @discardableResult
    func refreshToken(refreshToken: String) async throws -> Token
}

struct TokenIdentityClient: TokenIdentityClientProtocol {
    private let network: Network
    
    init(network: Network = Network(host: "accounts.spotify.com")) {
        self.network = network
    }

    func getToken(code: String, codeVerifier: String, redirectUri: URL) async throws -> Token {
        let request = TokenRequest(code: code, codeVerifier: codeVerifier, redirectUri: redirectUri.absoluteString)
        let tokenDTO: TokenDTO = try await network.request(request)
        let token = tokenDTO.toDomain()
        return token
    }
    
    func refreshToken(refreshToken: String) async throws -> Token {
        let request = RefreshTokenRequest(refreshToken: refreshToken)
        let tokenDTO: TokenDTO = try await network.request(request)
        let token = tokenDTO.toDomain()
        return token
    }
}
