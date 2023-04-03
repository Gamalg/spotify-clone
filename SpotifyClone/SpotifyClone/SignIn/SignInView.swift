//
//  SignInView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.03.2023.
//

import SwiftUI

struct SignInScreenView: View {
    var body: some View {
        BlackBGScreen {
            VStack {
                Spacer()
                Image.spotifyIconWhite
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 16)
                TitleText("Millions of songs.\nFree on Spotify.")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)
                BorderlessButton(title: "Log in") {
                    print("Log in")
                }
                Spacer()
            }
        }
    }
}

struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView()
    }
}
