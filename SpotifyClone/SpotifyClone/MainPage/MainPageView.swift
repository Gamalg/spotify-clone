//
//  MainPageView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 06.04.2023.
//

import SwiftUI
import Foundation.NSNotification

struct MainPageView: View {
    @StateObject var playerViewModel = PlayerViewModel()
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
            
            PlayingSongPreviewView()
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 48, trailing: 0))
        }
            .environmentObject(playerViewModel)
            .onAppear(perform: onAppear)
    }
    
    private func onAppear() {
        playerViewModel.connect()
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView(playerViewModel: PlayerViewModel.filledViewModel())
    }
}
