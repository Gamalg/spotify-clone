//
//  PlayerControlButton.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 06.06.2023.
//

import SwiftUI

struct PlayerControlButton: View {
    enum ButtonType {
        case next
        case previous
        case shuffle
        case `repeat`
        
        var imageName: String {
            switch self {
            case .next:
                return "forward.end.fill"
            case .previous:
                return "backward.end.fill"
            case .repeat:
                return "arrow.rectanglepath"
            case .shuffle:
                return "shuffle"
            }
        }
    }
    
    let type: PlayerControlButton.ButtonType
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: label)
            .frame(width: 44, height: 44)
            .foregroundColor(.white)
    }
    
    func label() -> some View {
        Image(systemName: type.imageName)
    }
}

struct PlayerControlButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PlayerControlButton(type: .next) {
            }
            PlayerControlButton(type: .previous) {
            }
            PlayerControlButton(type: .repeat) {
            }
            PlayerControlButton(type: .shuffle) {
            }
        }.preferredColorScheme(.dark)
    }
}
