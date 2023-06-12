//
//  SkipButton.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 07.06.2023.
//

import SwiftUI

struct SkipButton: View {
    enum Direction {
        case forward
        case backward
    }

    @EnvironmentObject var playerViewModel: PlayerViewModel
    let direction: Direction
    
    var body: some View {
        Button(action: skip, label: label)
    }
    
    private func skip() {
        switch direction {
        case .forward:
            self.playerViewModel.skipForward()
        case .backward:
            self.playerViewModel.skipBackward()
        }
    }
    
    private func label() -> some View {
        let imageName = direction == .forward ? "forward.end.fill" : "backward.end.fill"
        return Image(systemName: imageName)
            .foregroundColor(.white)
    }
}

struct SkipButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            SkipButton(direction: .backward)
            SkipButton(direction: .forward)
        }
    }
}
