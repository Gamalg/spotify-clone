//
//  SignInView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.03.2023.
//

import SwiftUI

struct SignInScreenView: View {
    private let viewModel = SignInViewModel()
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
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)
                BorderlessButton(title: "Log in") {
                    viewModel.auth()
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
