//
//  BorderlessButton.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.04.2023.
//

import SwiftUI

struct BorderlessButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(title, action: action)
            .foregroundColor(.white)
            .font(.body.weight(.semibold))
    }
}

struct BorderlessButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.spBlack
            BorderlessButton(title: "Title") {
            }
        }
    }
}
