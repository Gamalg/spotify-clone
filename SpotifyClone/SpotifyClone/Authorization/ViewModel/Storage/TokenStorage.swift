//
//  TokenStorage.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 06.04.2023.
//

import Foundation

struct TokenStorage {
    var get: () -> Token?
    var set: (Token) throws -> ()
}

extension TokenStorage {
    static let live: Self = TokenStorage {
        try? UserDefaults.standard.value(forKey: "TOKEN_STORAGE")
    } set: { token in
        try UserDefaults.standard.set(token, forKey: "TOKEN_STORAGE")
    }
}
