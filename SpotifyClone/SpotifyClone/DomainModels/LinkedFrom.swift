//
//  LinkedFrom.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.06.2023.
//

import Foundation

/**
 Part of the response when Track Relinking is applied and is only part of the response if the track linking, in fact, exists.
 The requested track has been replaced with a different track.
 The track in the linked_from object contains information about the originally requested track.
 */
struct LinkedFrom: Hashable, Decodable {
    let externalUrls: ExternalUrls
    let href: WebAPIEndpointLink
    let id: String
    /// The object type: "track".
    let type: String
    let uri: SpotifyURI
}
