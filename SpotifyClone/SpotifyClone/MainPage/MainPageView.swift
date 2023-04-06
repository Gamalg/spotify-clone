//
//  MainPageView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 06.04.2023.
//

import SwiftUI

struct MainPageView: View {
    var body: some View {
        BlackBGScreen {
            Text("Hello, it is your main page")
                .foregroundColor(.white)
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
