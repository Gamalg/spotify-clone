//
//  RepeatButton.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 07.06.2023.
//

import SwiftUI

struct RepeatButton: View {
    @EnvironmentObject var playerViewModel: PlayerViewModel
    var body: some View {
        Button(action: {
            playerViewModel.changeRepeatMode()
        }, label: label)
    }
    
    private func label() -> some View {
        switch playerViewModel.playbackState.repeatMode {
        case .repeatTrack:
            return Image(systemName: "repeat.1")
                .foregroundColor(.spGreen)
        case .repeatTrackList:
            return Image(systemName: "repeat")
                .foregroundColor(.spGreen)
        case .off:
            return Image(systemName: "repeat")
                .foregroundColor(.white)
        }
    }
}
