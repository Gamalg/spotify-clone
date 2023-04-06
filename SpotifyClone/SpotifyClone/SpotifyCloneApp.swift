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
    private let viewModel = SignInViewModel()
    var body: some Scene {
        WindowGroup {
            if viewModel.isSignedIn {
                MainPageView()
            } else {
                SignInScreenView()
            }
        }
    }
}
