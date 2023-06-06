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
            VStack(alignment: .leading) {
                SPTText(trackListItem.name,
                        style: .body)
                SPTText(trackListItem.authorName,
                        style: .caption1,
                        foregroundColor: .lightGray
                )
            }
            
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
