//
//  MainPageView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 06.04.2023.
//

import SwiftUI

struct MainPageView: View {
    var body: some View {
        TabView {
            HomePageView()
                .tabItem {
                    Label("Home", systemImage: "")
                }
            SearchPageView()
                .tabItem {
                    Label("Search", systemImage: "")
                }
            YourLibraryPageView()
                .tabItem {
                    Label("Library", systemImage: "")
                }
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
