//
//  SPTTextStyle.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 23.05.2023.
//

import Foundation
import SwiftUI

/*
 
 Possible fonts:
 
 Homepage:
 - Section title
 - Playlist name
 - Recommendation caption
 - Album name and author caption
 - More like
 
 */

enum SPTTextStyle {
    case headline1
    case headline2
    case headline3
    case headline4
    
    case body
    
    case caption1
    
    var font: Font {
        switch self {
        case .headline1:
            return .system(size: 23, weight: .bold)
        case .headline2:
            return .system(size: 21, weight: .bold)
        case .headline3:
            return .system(size: 19, weight: .bold)
        case .headline4:
            return .system(size: 15, weight: .bold)
        case .body:
            return .system(size: 15, weight: .regular)
        case .caption1:
            return .system(size: 11)
        }
    }
}

struct HomePageHeadlineText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(SPTTextStyle.headline1.font)
            .foregroundColor(.white)
    }
}
