//
//  RemoteImage.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.06.2023.
//

import Foundation

struct RemoteImage: Hashable, Decodable {
    let url: String
    let width: CGFloat?
    let height: CGFloat?
}
