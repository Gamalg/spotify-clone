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
    var body: some Scene {
        WindowGroup {
            SignInScreenView().onOpenURL { url in
                print(url)
            }
        }
    }
}
