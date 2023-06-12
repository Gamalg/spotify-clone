//
//  AlbumHomeGridItemView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 17.05.2023.
//

import SwiftUI

struct HomeCollectionGridItemView: View {
    struct Data {
        let imageURL: String
        let title: String?
        let subtitle: String
    }
    
    let viewData: HomeCollectionGridItemView.Data
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncCachedImage(url: viewData.imageURL,
                             placeholder: .playlist)
                .frame(width: 150, height: 150)
            TitleSubtitleText(
                title: viewData.title,
                subtitle: viewData.subtitle,
                style: .homePageItem
            )
        }
    }
}

struct AlbumHomeGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        BlackBGScreen {        
            HomeCollectionGridItemView(
                viewData: .init(imageURL: "",
                                title: "On an island",
                                subtitle: "David Glimour"))
        }
    }
}

extension HomeCollectionGridItemView.Data {
    init(album: Album) {
        self.imageURL = album.images.first?.url ?? ""
        self.title = album.name
        self.subtitle = "Album • \(album.artists.allArtists())"
    }
}
