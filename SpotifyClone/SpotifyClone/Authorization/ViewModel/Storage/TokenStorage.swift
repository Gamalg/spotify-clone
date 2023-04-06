//
//  TokenStorage.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 06.04.2023.
//

import Foundation

struct TokenStorage {
    var get: () -> Token?
    var set: (Token) -> ()
}

extension TokenStorage {
    static let live: Self = TokenStorage {
        UserDefaults.standard.value(forKey: "TOKEN_STORAGE") as? Token
    } set: { token in
        UserDefaults.standard.set(token, forKey: "TOKEN_STORAGE")
    }
}
