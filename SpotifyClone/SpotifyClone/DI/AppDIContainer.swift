//
//  AppDIContainer.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 25.04.2023.
//

import Foundation

class AppDIContainer {
    let tokenIdentityClient: TokenIdentityClientProtocol = TokenIdentityClient()
    var signInViewModel: SignInViewModel {
        SignInViewModel(tokenIdentityClient: tokenIdentityClient)
    }
    
    var appViewModel: AppViewModel {
        AppViewModel(tokenIdentityClient: tokenIdentityClient)
    }
}
