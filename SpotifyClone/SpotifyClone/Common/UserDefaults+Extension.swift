//
//  UserDefaults+Extension.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 06.04.2023.
//

import Foundation

enum UserDefaultsError: Error {
    case noData
}

extension UserDefaults {
    func value<T: Codable>(forKey: String) throws -> T {
        guard let data = data(forKey: forKey) else {
            throw UserDefaultsError.noData
        }

        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(T.self, from: data)
    }

    func set<T: Codable>(_ codable: T, forKey: String) throws {
        let jsonEncoder = JSONEncoder()
        let data = try jsonEncoder.encode(codable)
        setValue(data, forKey: forKey)
    }
}
