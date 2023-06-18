//
//  TrackListItemView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.06.2023.
//

import SwiftUI

struct TrackListItemView: View {
    let trackListItem: TrackListItem
    var body: some View {
        HStack {
            TitleSubtitleText(title: trackListItem.name,
                              subtitle: trackListItem.authorName,
                              style: .small)
            Spacer()
            Button(action: {}) {
                Image(systemName: "ellipsis")
            }
        }
    }
}

/**
 Needed data:
 - Name of container
 - Creator name
 - Array of tracks with song name, author, spotify track id
 */
struct TrackListItem: Identifiable {
    let name: String
    let authorName: String
    let spotifyURI: String
    let durationInSeconds: Double
    
    var id: String {
        spotifyURI
    }
}

extension TrackListItem {
    init(track: AppTrack) {
        self.name = track.name
        self.authorName = track.artist.name
        self.spotifyURI = track.uri
        self.durationInSeconds = Double(track.duration)
    }
}
