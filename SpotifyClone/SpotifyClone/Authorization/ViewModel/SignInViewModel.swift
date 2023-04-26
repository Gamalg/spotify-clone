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
    var signInURL: URL { get }
    
    @discardableResult
    func authenticate(code: String) async throws -> Token
}

class SignInViewModel: SignInViewModelProtocol {
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
    
    init(codeChallengeProvider: CodeChallengeProviding = CodeChallengeProvider(),
         tokenIdentityClient: TokenIdentityClientProtocol = TokenIdentityClient()) {
        self.codeChallangeProvider = codeChallengeProvider
        self.tokenIdentityClient = tokenIdentityClient
    }
    
    @discardableResult
    func authenticate(code: String) async throws -> Token {
        try await tokenIdentityClient.exchangeCodeForToken(code: code, codeVerifier: codeVerifier)
    }
}
