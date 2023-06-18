//
//  AppTrackContainer.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 18.06.2023.
//

import Foundation
import SpotifyiOS

class AppTrackContainer: NSObject {
    let name: String
    let creator: String
    let creatorImage: String
    let image: String
    let uri: SpotifyURI
    let tracks: [AppTrack]
    
    init(name: String, creator: String, creatorImage: String, image: String, uri: String, tracks: [AppTrack]) {
        self.name = name
        self.creator = creator
        self.creatorImage = creatorImage
        self.image = image
        self.uri = uri
        self.tracks = tracks
    }
}

extension AppTrackContainer: SPTAppRemoteContentItem {
    var title: String? {
        name
    }
    
    var subtitle: String? {
        creator
    }
    
    var identifier: String {
        "\(uri)?contextURI=\(uri)"
    }
    
    var isAvailableOffline: Bool {
        false
    }
    
    var isPlayable: Bool {
        true
    }
    
    var isContainer: Bool {
        true
    }
    
    var children: [SPTAppRemoteContentItem]? {
        tracks
    }
    
    var imageIdentifier: String {
        image
    }
}
