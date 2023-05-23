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
    @ObservedObject var viewModel: AppViewModel
    
    init() {
        viewModel = AppDIContainer.shared.appViewModel
    }
    
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
    let appDIContainer: AppDIContainer = AppDIContainer.shared
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

    private var subscriptions: Set<AnyCancellable> = []
    private var tokenStorage: TokenStorage
    private var sessionArchive: SessionArchiving
    
    init(tokenStorage: TokenStorage, sessionArchive: SessionArchiving) {
        self.tokenStorage = tokenStorage
        self.sessionArchive = sessionArchive
    }
        
    func onAppear() {
        tokenStorage.token
            .sink { [weak self] token in
                self?.updateState(token: token)
            }
            .store(in: &subscriptions)
        
        sessionArchive.resumeSessionIfPossible()
    }
    
    private func updateState(token: Token?) {
        Task {
            await MainActor.run(body: {
                if token != nil {
                    state = .signedIn
                } else {
                    state = .signedOut
                }
            })
        }
    }
}
