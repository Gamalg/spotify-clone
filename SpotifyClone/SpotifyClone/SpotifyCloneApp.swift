//
//  SpotifyCloneApp.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.03.2023.
//

import SwiftUI
import SpotifyiOS
import Foundation

@main
struct SpotifyCloneApp: App {
    let signInViewModel: SignInViewModel = .init()
    var body: some Scene {
        WindowGroup {
            SignInScreenView().onOpenURL { url in
                print(url)
                if let code = getCode(from: url) {
                    signInViewModel.authRequest(code: code, redirectUri: url)
                }
            }
        }
    }
    
    private func getCode(from url: URL) -> String? {
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        return urlComponents?.queryItems?.first { $0.name == "code" }?.value
    }
}
