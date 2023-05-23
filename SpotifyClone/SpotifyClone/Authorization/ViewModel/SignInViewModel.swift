//
//  SignInViewModel.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 23.05.2023.
//

import Foundation

protocol SignInViewModelProtocol {
    func signIn()
    func signOut()
    
    func handleAuthURL(_ url: URL)
}

class SignInViewModel: NSObject, SignInViewModelProtocol {
    private let authService: AuthServiceProtocol
    private let signOutService: SignOutServiceProtocol
    private let urlHandler: URLHandlerProtocol
    
    init(authService: AuthServiceProtocol, signOutService: SignOutServiceProtocol, urlHandler: URLHandlerProtocol) {
        self.authService = authService
        self.signOutService = signOutService
        self.urlHandler = urlHandler
    }
    
    func signIn() {
        authService.signIn()
    }
    
    func signOut() {
        signOutService.signOut()
    }
    
    func handleAuthURL(_ url: URL) {
        urlHandler.handle(url)
    }
}

struct SignInViewModelMock: SignInViewModelProtocol {
    func signIn() {
    }
    
    func signOut() {
    }
    
    func handleAuthURL(_ url: URL) {
    }
}

