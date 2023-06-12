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
            ShuffleButton()
            Spacer()
            SkipButton(direction: .backward)
            Spacer()
            PlayButton(style: .rounded)
                .frame(width: 44, height: 44)
                .padding(.trailing)
            Spacer()
            SkipButton(direction: .forward)
            Spacer()
            RepeatButton()
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
