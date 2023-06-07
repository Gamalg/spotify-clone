//
//  ShuffleButton.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 07.06.2023.
//

import SwiftUI

struct ShuffleButton: View {
    @EnvironmentObject var playerViewModel: PlayerViewModel
    var body: some View {
        Button(action: playerViewModel.toggleShuffled, label: label)
    }
    
    private func label() -> some View {
        if playerViewModel.playbackState.isShuffled {
           return Image(systemName: "shuffle")
                .foregroundColor(.spGreen)
        }
        
        return Image(systemName: "shuffle")
            .foregroundColor(.white)
    }
}

struct ShuffleButton_Previews: PreviewProvider {
    static var previews: some View {
        ShuffleButton()
    }
}
