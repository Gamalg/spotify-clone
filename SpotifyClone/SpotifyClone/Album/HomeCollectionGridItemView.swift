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
    var href: String
    
    internal init(name: String, artistName: String, coverImageURL: String, href: String) {
        self.name = name
        self.artistName = artistName
        self.coverImageURL = coverImageURL
        self.href = href
    }
    
    init(album: Album) {
        self.name = album.name
        self.artistName = album.artists.first?.name ?? ""
        self.coverImageURL = album.images.first?.url ?? ""
        self.href = album.href
    }
}

struct HomeCollectionGridItemView: View {
    let album: AlbumHomeGridItemViewData
    var body: some View {
        VStack(alignment: .leading) {
            AsyncCachedImage(url: album.coverImageURL,
                             placeholder: .playlist)
                .frame(width: 150, height: 150)
            Text(album.name)
                .foregroundColor(.white)
            Text(album.artistName)
                .foregroundColor(.white)
        }
    }
}

struct AlbumHomeGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCollectionGridItemView(album: .init(name: "Album",
                                           artistName: "Artist",
                                           coverImageURL: "",
                                           href: ""))
    }
}
