//
//  TitleText.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.04.2023.
//

import SwiftUI

struct TitleText: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.title)
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText("Hi")
    }
}
