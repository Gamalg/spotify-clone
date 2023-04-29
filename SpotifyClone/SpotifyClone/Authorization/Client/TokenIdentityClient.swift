//
//  TokenIdentityClient.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 20.04.2023.
//

import Foundation
import Combine

protocol TokenIdentityClientProtocol {
    var token: PassthroughSubject<Token?, Never> { get }
    @discardableResult
    func getToken() async throws -> Token
    
    @discardableResult
    func exchangeCodeForToken(code: String, codeVerifier: String) async throws -> Token
    
    func removeToken()
}

enum TokenError: Error {
    case noToken
}

class TokenIdentityClient: TokenIdentityClientProtocol {
    var token: PassthroughSubject<Token?, Never> = .init()
    private let network: Network
    private let storage: TokenStorage
    
    init(network: Network = Network(host: "accounts.spotify.com"), storage: TokenStorage = .live) {
        self.network = network
        self.storage = storage
    }

    func getToken() async throws -> Token {
        guard let token = storage.get() else {
            throw TokenError.noToken
        }
        
        guard token.hasTokenExpired else { return token }
        
        return try await refreshToken(refreshToken: token.refreshToken)
    }
    
    func exchangeCodeForToken(code: String, codeVerifier: String) async throws -> Token {
        let request = TokenRequest(code: code, codeVerifier: codeVerifier)
        let tokenDTO: TokenRequestResponse = try await network.request(request)
        let token = tokenDTO.toDomain()
        try storage.set(token)
        self.token.send(token)
        return token
    }
    
    private func refreshToken(refreshToken: String) async throws -> Token {
        let request = RefreshTokenRequest(refreshToken: refreshToken)
        let tokenDTO: TokenRequestResponse = try await network.request(request)
        let token = tokenDTO.toDomain()
        try storage.set(token)
        return token
    }
    
    func removeToken() {
        token.send(nil)
        storage.remove()
    }
}
