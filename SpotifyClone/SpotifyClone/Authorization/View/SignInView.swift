//
//  SignInView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.03.2023.
//

import SwiftUI

struct SignInScreenView: View {
    private let viewModel = SignInViewModel()
    @State var shouldPresentSheet = false
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
                    shouldPresentSheet = true
                }
                .sheet(isPresented: $shouldPresentSheet) {
                    print("Sheet dismissed!")
                } content: {
                    WebView(type: .public, url: viewModel.signInURL, signInViewModel: viewModel)
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
