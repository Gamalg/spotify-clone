//
//  BlackBGScreen.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.04.2023.
//

import SwiftUI

struct BlackBGScreen<Body: View>: View {
    @ViewBuilder var bodyView: () -> Body
    var body: some View {
        ZStack {
            Color.spBlack.ignoresSafeArea()
            bodyView()
        }
    }
}

struct BlackBGScreen_Previews: PreviewProvider {
    static var previews: some View {
        BlackBGScreen {
            Text("Hello, world!")
                .foregroundColor(.white)
        }
    }
}
