//
//  TokenStorage.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 06.04.2023.
//

import Foundation
import Combine

protocol TokenStorage {
    var token: CurrentValueSubject<Token?, Never> { get }
}
