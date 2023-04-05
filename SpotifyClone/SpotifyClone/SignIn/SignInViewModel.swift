//
//  SignInViewModel.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.04.2023.
//

import Foundation
import SpotifyiOS

protocol SignInViewModelProtocol {
    func auth()
}

class SignInViewModel: NSObject, SignInViewModelProtocol {
    let spotifyClientID = "d5266d28457741dc81d9b8172ff32bd5"
    let spotifyRedirectURL = URL(string: "g-spotify://g-spotify-callback")
    lazy var configuration = SPTConfiguration(
      clientID: spotifyClientID,
      redirectURL: spotifyRedirectURL!
    )
    
    lazy var manager = SPTSessionManager(configuration: configuration, delegate: self)
    
    func auth() {
        manager.initiateSession(with: .appRemoteControl)
    }
}

extension SignInViewModel: SPTSessionManagerDelegate {
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("didInitiate session:", session.accessToken)
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print(error)
    }
}
