//
//  SpotifyCloneApp.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.03.2023.
//

import SwiftUI
import SpotifyiOS
import Foundation

/**
 Thread issues described in this post Xcode 14 & iOS 16 purple warnings starting with "[Security] This method should not .. "  -
 https://developer.apple.com/forums/thread/714467?answerId=734799022#734799022
 
 Related to poor interaction between WKWebView, Security framework, and this Xcode feature is a known issue (r. 94019453).
 We plan to address it at some point but I don’t have any info to share as to when that’ll happen.
 */
@main
struct SpotifyCloneApp: App {
    @StateObject var viewModel: AppViewModel = AppViewModel()
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(viewModel: viewModel)
                .onAppear(perform: viewModel.onAppear)
        }
    }
}

enum AppState {
    case signedIn
    case signedOut
    case checkingForToken
}

struct AppCoordinatorView: View {
    @ObservedObject var viewModel: AppViewModel
    var body: some View {
        switch viewModel.state {
        case .checkingForToken:
            BlackBGScreen {            
                ProgressView()
                    .tint(.white)
            }
        case .signedIn:
            MainPageView()
        case .signedOut:
            SignInScreenView()
        }
    }
}

@MainActor
class AppViewModel: ObservableObject {
    @Published var state: AppState = .checkingForToken

    private let tokenStorage = TokenStorage.live
    private let tokenIdentityClient = TokenIdentityClient()
    
    func onAppear() {
        if let token = tokenStorage.get() {
            checkForToken(token)
        } else {
            state = .signedOut
        }
    }
    
    private func checkForToken(_ token: Token) {
        guard token.hasTokenExpired else {
            self.state = .signedIn
            return
        }

        refreshToken(token)
    }
    
    private func refreshToken(_ token: Token) {
        Task {
            do {
                let newToken = try await tokenIdentityClient.refreshToken(refreshToken: token.refreshToken, redirectUri: URL(string: GlobalConstants.redirectURI)!)
                try tokenStorage.set(newToken)
                self.state = .signedIn
            } catch {
                self.state = .signedOut
            }
        }
    }
}
