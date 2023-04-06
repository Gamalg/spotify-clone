//
//  SignInViewModel.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.04.2023.
//

import Foundation
import CryptoKit

protocol SignInViewModelProtocol {
    func auth()
}

class SignInViewModel: SignInViewModelProtocol {
    private let tokenStorage = TokenStorage.live
    private let codeChallangeProvider: CodeChallengeProviding = CodeChallengeProvider()
    private let network = Network()
    
    private lazy var state = codeChallangeProvider.codeVerifier(length: 16)
    private lazy var codeVerifier = codeChallangeProvider.codeVerifier(length: 53)
    private lazy var codeChallenge: String = {
        codeChallangeProvider.codeChallenge(codeVerifier: codeVerifier) ?? ""
    }()
    
    func auth() {
    }
    
    func authorize() -> String {
        let authorize = AuthorizeRequest(state: state, codeChallenge: codeChallenge)
        return network.urlRequest(from: authorize).url?.absoluteString ?? ""
    }
    
    func tokenRequest(code: String, redirectUri: URL) async throws -> Token {
        let request = TokenRequest(code: code, codeVerifier: codeVerifier, redirectUri: redirectUri.absoluteString)
        let token: Token = try await network.request(request)
        tokenStorage.set(token)

        return token
    }
}
