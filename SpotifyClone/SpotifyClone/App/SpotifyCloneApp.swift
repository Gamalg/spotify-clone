//
//  SpotifyCloneApp.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.03.2023.
//

import SwiftUI
import Foundation
import Combine

@main
struct SpotifyCloneApp: App {
    private let appDIContainer = AppDIContainer()
    @ObservedObject var viewModel: AppViewModel
    
    init() {
        viewModel = appDIContainer.appViewModel
    }
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(viewModel: viewModel, appDIContainer: appDIContainer)
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
    let appDIContainer: AppDIContainer
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
            SignInScreenView(viewModel: appDIContainer.signInViewModel)
        }
    }
}

class AppViewModel: ObservableObject {
    @Published var state: AppState = .checkingForToken

    private let tokenStorage = TokenStorage.live
    private let tokenIdentityClient: TokenIdentityClientProtocol
    private var subscriptions: Set<AnyCancellable> = []
    
    init(tokenIdentityClient: TokenIdentityClientProtocol) {
        self.tokenIdentityClient = tokenIdentityClient
    }
    
    func onAppear() {
        tokenIdentityClient.token
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.state = .signedIn
            }
            .store(in: &subscriptions)
        
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
                let newToken = try await tokenIdentityClient.refreshToken(refreshToken: token.refreshToken)
                try tokenStorage.set(newToken)
                await MainActor.run {
                    self.state = .signedIn
                }
            } catch {
                await MainActor.run {
                    self.state = .signedOut
                }
            }
        }
    }
}
