//
//  SpotifyColors.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.03.2023.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var hexValue: UInt64 = 0
        
        guard Scanner(string: hexString).scanHexInt64(&hexValue) else {
            self.init(white: 1.0)
            return
        }
        
        let red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat((hexValue & 0x0000FF)) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

extension Color {
    static let spGreen = Color(hex: "#1DB954")
    static let spBlack = Color(hex: "#191414")
}
