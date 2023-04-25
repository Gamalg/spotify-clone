//
//  SignInView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.03.2023.
//

import SwiftUI

struct SignInScreenView: View {
    private let viewModel: SignInViewModelProtocol
    
    init(viewModel: SignInViewModelProtocol) {
        self.viewModel = viewModel
    }
    
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
                    UIApplication.shared.open(viewModel.signInURL)
                }
                Spacer()
            }
        }.onOpenURL(perform: openURL(url:))
    }
    
    private func openURL(url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        guard let code = components?.queryItems?.first(where: { $0.name == "code" })?.value else { return }
        Task {
            do {
                try await viewModel.authenticate(code: code)
            } catch {
                // some error handler
            }
        }
    }
}

struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView(viewModel: SignInViewModel())
    }
}
