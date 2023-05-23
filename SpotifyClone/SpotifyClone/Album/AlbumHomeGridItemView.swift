//
//  AlbumHomeGridItemView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 17.05.2023.
//

import SwiftUI

struct AlbumHomeGridItemViewData: Hashable {
    var name: String
    var artistName: String
    var coverImageURL: String
    
    internal init(name: String, artistName: String, coverImageURL: String) {
        self.name = name
        self.artistName = artistName
        self.coverImageURL = coverImageURL
    }
    
    init(album: Album) {
        self.name = album.name
        self.artistName = album.artists.first?.name ?? ""
        self.coverImageURL = album.images.first?.url ?? ""
    }
}

struct AlbumHomeGridItemView: View {
    let album: AlbumHomeGridItemViewData
    var body: some View {
        VStack(alignment: .leading) {
            AsyncCachedImage(url: album.coverImageURL,
                             placeholder: .playlist)
                .frame(width: 150, height: 150)
            Text(album.name)
            Text(album.artistName)
        }
    }
}

struct AlbumHomeGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumHomeGridItemView(album: .init(name: "Album",
                                           artistName: "Artist",
                                           coverImageURL: ""))
    }
}
