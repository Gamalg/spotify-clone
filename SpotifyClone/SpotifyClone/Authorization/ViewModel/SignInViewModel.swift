//
//  SignInViewModel.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.04.2023.
//

import Foundation
import CryptoKit

protocol SignInViewModelProtocol {
    var isSignedIn: Bool { get }
    var signInURL: URL { get }
    func authenticate(code: String, redirectUri: URL) async throws
}

class SignInViewModel: SignInViewModelProtocol {
    private let tokenStorage: TokenStorage
    private let codeChallangeProvider: CodeChallengeProviding
    private let network: Network
    
    private lazy var state = codeChallangeProvider.codeVerifier(length: 16)
    private lazy var codeVerifier = codeChallangeProvider.codeVerifier(length: 53)
    private lazy var codeChallenge: String = {
        codeChallangeProvider.codeChallenge(codeVerifier: codeVerifier) ?? ""
    }()
    
    var signInURL: URL {
        let authorize = AuthorizeRequest(state: state, codeChallenge: codeChallenge)
        return network.urlRequest(from: authorize).url!
    }
    
    var isSignedIn: Bool {
        tokenStorage.get() != nil
    }
    
    init(tokeStorage: TokenStorage = .live,
         codeChallengeProvider: CodeChallengeProviding = CodeChallengeProvider(),
         network: Network = Network()) {
        self.tokenStorage = tokeStorage
        self.codeChallangeProvider = codeChallengeProvider
        self.network = network
    }
    
    func authenticate(code: String, redirectUri: URL) async throws {
        let request = TokenRequest(code: code, codeVerifier: codeVerifier, redirectUri: redirectUri.absoluteString)
        let token: Token = try await network.request(request)
        try tokenStorage.set(token)
    }
}
