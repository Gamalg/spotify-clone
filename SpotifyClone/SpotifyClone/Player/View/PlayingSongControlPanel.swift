//
//  PlayingSongControlPanel.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 06.06.2023.
//

import SwiftUI

struct PlayingSongControlPanelView: View {
    var body: some View {
        HStack {
            PlayerControlButton(type: .shuffle) {
            }
            Spacer()
            PlayerControlButton(type: .previous) {
            }.padding(.trailing)
            Spacer()
            PlayButton(style: .rounded, isPlaying: true) {
                
            }.frame(width: 44, height: 44)
            .padding(.trailing)
            Spacer()
            PlayerControlButton(type: .next) {
            }
            Spacer()
            PlayerControlButton(type: .repeat) {
            }
        }
    }
}

struct PlayingSongControlPanel_Previews: PreviewProvider {
    static var previews: some View {
        BlackBGScreen {
            PlayingSongControlPanelView()
        }
    }
}
