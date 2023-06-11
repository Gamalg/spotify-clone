//
//  TitleSubtitleText.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 07.06.2023.
//

import SwiftUI

struct TitleSubtitleText: View {
    enum Style {
        case medium
        case small
        case homePageItem
        
        var titleTextStyle: SPTTextStyle {
            switch self {
            case .medium:
                return .headline3
            case .small:
                return .headline4
            case .homePageItem:
                return .h13
            }
        }
        
        var subtitleTextStyle: SPTTextStyle {
            switch self {
            case .medium:
                return .body
            case .small:
                return .caption1
            case .homePageItem:
                return .caption1
            }
        }
    }

    let title: String?
    let subtitle: String
    
    let style: TitleSubtitleText.Style
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title = title {
                SPTText(title, style: style.titleTextStyle)
            }

            SPTText(subtitle, style: style.subtitleTextStyle, foregroundColor: .lightGray)
        }
    }
}

struct TitleSubtitleText_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .top) {
            TitleSubtitleText(title: "Meteora", subtitle: "Linkin Park", style: .medium)
                .padding()
            TitleSubtitleText(title: "Meteora", subtitle: "Linkin Park", style: .small)
                .padding()
        }.preferredColorScheme(.dark).previewLayout(.sizeThatFits)
    }
}
