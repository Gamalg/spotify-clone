//
//  AppDIContainer.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 25.04.2023.
//

import Foundation
import SpotifyiOS

class AppDIContainer {
    // TODO: - Rework shared singleton
    static let shared = AppDIContainer()
    
    lazy var sessionManager: SPTSessionManager = {
        SPTSessionManager(
            configuration: SPTConfiguration(clientID: GlobalConstants.spotifyClientID, redirectURL: URL(string: GlobalConstants.redirectURI)!),
            delegate: nil)
    }()
    
    lazy var authManager = SPTSessionManagerAuthorization(sessionManager: sessionManager)

    var signInViewModel: SignInViewModel {
        SignInViewModel(authService: authManager, signOutService: authManager, urlHandler: authManager)
    }
    
    var appViewModel: AppViewModel {
        AppViewModel(tokenStorage: authManager, sessionArchive: authManager)
    }
    
    lazy var network = Network(tokenStorage: authManager, authService: authManager)
}
