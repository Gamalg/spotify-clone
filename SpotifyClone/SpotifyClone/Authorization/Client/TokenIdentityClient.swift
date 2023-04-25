//
//  TokenIdentityClient.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 20.04.2023.
//

import Foundation
import Combine

protocol TokenIdentityClientProtocol {
    var token: PassthroughSubject<Token, Never> { get }
    @discardableResult
    func getToken(code: String, codeVerifier: String) async throws -> Token
    
    @discardableResult
    func refreshToken(refreshToken: String) async throws -> Token
}

class TokenIdentityClient: TokenIdentityClientProtocol {
    var token: PassthroughSubject<Token, Never> = .init()
    private let network: Network
    
    init(network: Network = Network(host: "accounts.spotify.com")) {
        self.network = network
    }

    func getToken(code: String, codeVerifier: String) async throws -> Token {
        let request = TokenRequest(code: code, codeVerifier: codeVerifier)
        let tokenDTO: TokenDTO = try await network.request(request)
        let token = tokenDTO.toDomain()
        self.token.send(token)
        return token
    }
    
    func refreshToken(refreshToken: String) async throws -> Token {
        let request = RefreshTokenRequest(refreshToken: refreshToken)
        let tokenDTO: TokenDTO = try await network.request(request)
        let token = tokenDTO.toDomain()
        return token
    }
}
