//
//  MainPageView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 06.04.2023.
//

import SwiftUI

@MainActor
class MainPageViewModel: ObservableObject {
    let network = Network()
    
    @Published var displayName: String = ""
    
    func fetchUserProfile() {
        let userProfileRequest = GetCurrentUserProfileRequest()
        Task {        
            do {
                let userProfile: UserProfile = try await network.request(userProfileRequest)
                displayName = userProfile.displayName
            } catch {
                displayName = "Sorry, failed to fetch user profile"
            }
        }
    }
}

struct MainPageView: View {
    @StateObject private var mainPageViewModel = MainPageViewModel()
    var body: some View {
        BlackBGScreen {
            Text("Hello, it is your main page: \(mainPageViewModel.displayName)")
                .foregroundColor(.white)
        }.onAppear(perform: mainPageViewModel.fetchUserProfile)
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
