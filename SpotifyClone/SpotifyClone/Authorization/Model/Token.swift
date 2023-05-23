//
//  Token.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 23.05.2023.
//

import Foundation
import SpotifyiOS

struct Token {
    var accessToken: String {
        session.accessToken
    }
    
    var isExpired: Bool {
        session.isExpired
    }
    
    private let session: SPTSession
    
    init(session: SPTSession) {
        self.session = session
    }
}

extension SPTSession {
    func toToken() -> Token {
        Token(session: self)
    }
}
