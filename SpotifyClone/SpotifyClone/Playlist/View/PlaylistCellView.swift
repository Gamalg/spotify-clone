//
//  PlaylistCellView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 12.05.2023.
//

import SwiftUI

struct PlaylistCellViewData: Hashable {
    let name: String
    let imageUrl: String
}

struct PlaylistCellView: View {
    let playlist: PlaylistCellViewData
    
    var body: some View {
        HStack {
            AsyncCachedImage(url: playlist.imageUrl, placeholder: .playlist)
                .frame(width: 50, height: 50)
            Text(playlist.name)
                .font(.caption)
        }
    }
}

struct PlaylistCellView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistCellView(playlist: PlaylistCellViewData(
            name: "Playlist",
            imageUrl: "")
        )
    }
}
