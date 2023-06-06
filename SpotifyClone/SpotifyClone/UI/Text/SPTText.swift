//
//  SPTText.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.06.2023.
//

import SwiftUI

struct SPTText: View {
    let title: String
    let style: SPTTextStyle
    let foregroundColor: Color
    
    init(_ title: String, style: SPTTextStyle, foregroundColor: Color = .white) {
        self.title = title
        self.style = style
        self.foregroundColor = foregroundColor
    }
    
    var body: some View {
        Text(title)
            .font(style.font)
            .foregroundColor(foregroundColor)
    }
}

struct SPTText_PreviewProvider: PreviewProvider {
    static var previews: some View {
        BlackBGScreen {
            VStack {
                SPTText("Headline 1", style: .headline1)
                    .padding(.bottom)
                SPTText("Headline 2", style: .headline2)
                    .padding(.bottom)
                SPTText("Headline 3", style: .headline3)
                    .padding(.bottom)
                SPTText("Body", style: .body)
                    .padding(.bottom)
                SPTText("Caption 1", style: .caption1)
                    .padding(.bottom)
            }
        }
    }
}
