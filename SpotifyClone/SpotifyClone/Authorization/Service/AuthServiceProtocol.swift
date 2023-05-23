//
//  AuthServiceProtocol.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 23.05.2023.
//

import Foundation.NSUserDefaults
import Foundation
import SpotifyiOS
import Combine

protocol URLHandlerProtocol {
    func handle(_ url: URL)
}

protocol AuthServiceProtocol {
    func signIn()
    func refreshToken()
}

protocol SignOutServiceProtocol {
    func signOut()
}

protocol SessionArchiving {
    func saveSession(_ session: SPTSession)
    func resumeSessionIfPossible()
}

class SPTSessionManagerAuthorization: NSObject,
                                        AuthServiceProtocol, SignOutServiceProtocol, TokenStorage,
                                        URLHandlerProtocol, SessionArchiving, SPTSessionManagerDelegate {
    var token: CurrentValueSubject<Token?, Never> = .init(nil)
    
    private let sessionManager: SPTSessionManager
    
    init(sessionManager: SPTSessionManager) {
        self.sessionManager = sessionManager
        
        super.init()
        
        self.sessionManager.delegate = self
    }
    
    func signIn() {
        sessionManager.initiateSession(
            with: [.userReadPrivate, .userReadEmail, .userLibraryRead, .userTopRead]
        )
    }
        
    func refreshToken() {
        sessionManager.renewSession()
    }
    
    func signOut() {
        token.send(nil)
    }
    
    func handle(_ url: URL) {
        sessionManager.application(UIApplication.shared, open: url)
    }
    
    // MARK: - Session Manager Delegate
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        token.send(session.toToken())
        saveSession(session)
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        
    }
    
    func sessionManager(manager: SPTSessionManager, shouldRequestAccessTokenWith code: String) -> Bool {
        true
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        token.send(session.toToken())
        saveSession(session)
    }
    
    private let sessionFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        .appendingPathComponent("session")
    
    func saveSession(_ session: SPTSession) {
        do {
            let dataEncoded = try NSKeyedArchiver.archivedData(withRootObject: session, requiringSecureCoding: true)
            try dataEncoded.write(to: sessionFileURL)
        } catch {
            // do nothing for  now
        }
    }
    
    func resumeSessionIfPossible() {
        do {
            let dataDecoded = try Data(contentsOf: sessionFileURL)
            let session = try NSKeyedUnarchiver.unarchivedObject(ofClass: SPTSession.self, from: dataDecoded)
            sessionManager.session = session
            
            if let session = session {
                if session.isExpired {
                    refreshToken()
                } else {
                    token.send(session.toToken())
                }
            }
            
        } catch {
            // do nothing
        }
    }
}
