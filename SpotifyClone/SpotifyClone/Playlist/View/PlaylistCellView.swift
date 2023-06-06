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
    let id: SpotifyID
}

struct PlaylistCellView: View {
    let playlist: PlaylistCellViewData
    
    var body: some View {
        HStack {
            AsyncCachedImage(url: playlist.imageUrl, placeholder: .playlist)
                .frame(width: 50, height: 50)
            SPTText(playlist.name, style: .caption1)
            Spacer()
        }.background(Color.gray.opacity(0.2))
        .cornerRadius(5)
    }
}

struct PlaylistCellView_Previews: PreviewProvider {
    static var previews: some View {
        BlackBGScreen {
            PlaylistCellView(playlist: PlaylistCellViewData(
                name: "Playlist",
                imageUrl: "",
                id: "")
            )
        }
    }
}
