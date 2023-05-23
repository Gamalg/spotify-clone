//
//  MainPageView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 06.04.2023.
//

import SwiftUI

struct MainPageView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView {
                HomePageView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                SearchPageView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                YourLibraryPageView()
                    .tabItem {
                        Label("Library", systemImage: "rectangle.portrait.on.rectangle.portrait.angled.fill")
                    }
            }
            
            Text("Here will be player")
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 49, trailing: 0))
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
