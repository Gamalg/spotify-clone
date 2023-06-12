//
//  Milliseconds.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 07.06.2023.
//

import Foundation

typealias Milliseconds = UInt

extension Milliseconds {
    func toSeconds() -> UInt {
        self / 1000
    }
}

extension Int {
    func toSeconds() -> Int {
        self / 1000
    }
}
