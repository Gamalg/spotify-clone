//
//  ImagePlaceholder.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 12.05.2023.
//

import SwiftUI

struct ImagePlaceholder {
    enum PlaceholderType {
        case system(String)
        case custom(String)
    }
    
    let type: PlaceholderType
    let backgroundColor: Color
    let tintColor: Color
}

extension ImagePlaceholder {
    static let playlist: ImagePlaceholder = ImagePlaceholder(
        type: .system("music.note.list"),
        backgroundColor: Color(uiColor: UIColor.darkGray),
        tintColor: Color(uiColor: UIColor.lightGray)
    )
}
