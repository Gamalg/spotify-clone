//
//  GetCurrentUserProfileRequest.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 24.04.2023.
//

import Foundation
import SpotifyiOS

struct UserProfile: Codable {
    var displayName: String
}

struct GetCurrentUserProfileRequest: Request {
    // TODO: Add API version
    var path: String = "/v1/me"
    var method: HTTPMethod = .GET
    var parameters: [String : Any] = [:]
    var headers: [String : String] = [:]
    var neededAuth: Bool = true
}
