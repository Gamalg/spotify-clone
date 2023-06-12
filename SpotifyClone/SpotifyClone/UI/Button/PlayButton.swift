//
//  PlayButton.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 06.06.2023.
//

import SwiftUI

struct PlayButton: View {
    enum Style {
        case rounded
        case roundedGreen
        case borderless
        
        var playImageName: String {
            switch self {
            case .rounded:
                return "play.circle.fill"
            case .roundedGreen:
                return "play.circle.fill"
            case .borderless:
                return "play.fill"
            }
        }
        
        var pauseImageName: String {
            switch self {
            case .rounded:
                return "pause.circle.fill"
            case .roundedGreen:
                return "pause.circle.fill"
            case .borderless:
                return "pause.fill"
            }
        }
        
        var tintColor: Color {
            switch self {
            case .rounded:
                return .white
            case .roundedGreen:
                return .black
            case .borderless:
                return .white
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .rounded:
                return .white
            case .roundedGreen:
                return .spGreen
            case .borderless:
                return .white
            }
        }
    }

    let style: PlayButton.Style
    
    @EnvironmentObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        Button {
            playerViewModel.isPlaying ? playerViewModel.pause() : playerViewModel.resume()
        } label: {
            if playerViewModel.isPlaying {
                pauseImage
            } else {
                playImage
            }
        }
    }
    
    var playImage: some View {
        Image(systemName: style.playImageName)
            .resizable()
            .foregroundColor(style.foregroundColor)
            .tint(style.tintColor)
    }
    
    var pauseImage: some View {
        Image(systemName: style.pauseImageName)
            .resizable()
            .foregroundColor(style.foregroundColor)
            .tint(style.tintColor)
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            VStack {
                PlayButton(style: .borderless)
                    .frame(width: 44, height: 44)
                PlayButton(style: .rounded)
                    .frame(width: 44, height: 44)
                PlayButton(style: .roundedGreen)
                    .frame(width: 44, height: 44)
            }
            VStack {
                PlayButton(style: .borderless)
                    .frame(width: 44, height: 44)
                PlayButton(style: .rounded)
                    .frame(width: 44, height: 44)
                PlayButton(style: .roundedGreen)
                    .frame(width: 44, height: 44)
            }
        }.previewLayout(.sizeThatFits).preferredColorScheme(.dark)
    }
}
