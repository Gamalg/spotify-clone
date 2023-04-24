//
//  SignInViewModel.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.04.2023.
//

import Foundation
import CryptoKit
import SpotifyiOS

protocol SignInViewModelProtocol {
    var isSignedIn: Bool { get }
    var signInURL: URL { get }
    
    @discardableResult
    func authenticate(code: String, redirectUri: URL) async throws -> Token
}

class SignInViewModel: SignInViewModelProtocol {
    private let tokenStorage: TokenStorage
    private let codeChallangeProvider: CodeChallengeProviding
    private let tokenIdentityClient: TokenIdentityClientProtocol
    
    private lazy var state = codeChallangeProvider.codeVerifier(length: 16)
    private lazy var codeVerifier = codeChallangeProvider.codeVerifier(length: 53)
    private lazy var codeChallenge: String = {
        codeChallangeProvider.codeChallenge(codeVerifier: codeVerifier) ?? ""
    }()
    
    var signInURL: URL {
        AuthorizeRequest(state: state, codeChallenge: codeChallenge)
            .toURLRequest()
            .url!
    }
    
    var isSignedIn: Bool {
        !(tokenStorage.get()?.hasTokenExpired ?? true)
    }
    
    init(tokeStorage: TokenStorage = .live,
         codeChallengeProvider: CodeChallengeProviding = CodeChallengeProvider(),
         tokenIdentityClient: TokenIdentityClientProtocol = TokenIdentityClient()) {
        self.tokenStorage = tokeStorage
        self.codeChallangeProvider = codeChallengeProvider
        self.tokenIdentityClient = tokenIdentityClient
    }
    
    func authenticate(code: String, redirectUri: URL) async throws -> Token {
        let token = try await tokenIdentityClient.getToken(code: code, codeVerifier: codeVerifier, redirectUri: redirectUri)
        try tokenStorage.set(token)
        return token
    }
}
