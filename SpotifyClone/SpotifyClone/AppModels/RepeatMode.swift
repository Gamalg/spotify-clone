//
//  RepeatMode.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 07.06.2023.
//

import Foundation
import SpotifyiOS

enum RepeatMode {
    case repeatTrack
    case repeatTrackList
    case off
    
    func next() -> RepeatMode {
        switch self {
        case .off:
            return .repeatTrackList
        case .repeatTrackList:
            return .repeatTrack
        case .repeatTrack:
            return .off
        }
    }
}

extension RepeatMode {
    func toSPTAppRemotePlaybackOptionsRepeatMode() -> SPTAppRemotePlaybackOptionsRepeatMode {
        switch self {
        case .repeatTrack:
            return .track
        case .repeatTrackList:
            return .context
        case .off:
            return .off
        }
    }
}

extension SPTAppRemotePlaybackOptionsRepeatMode {
    func toRepeatMode() -> RepeatMode {
        switch self {
        case .off:
            return .off
        case .track:
            return .repeatTrack
        case .context:
            return .repeatTrackList
        @unknown default:
            return .off
        }
    }
}
