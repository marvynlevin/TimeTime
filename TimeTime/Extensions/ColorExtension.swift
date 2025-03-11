//
//  ColorExtension.swift
//  TimeTime
//
//  Created by levin marvyn on 11/03/2025.
//

import SwiftUI

extension Color {
    init (hex: String) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
                
        let red = Double((color & 0xFF0000) >> 16) / 255.0
        let green = Double((color & 0x00FF00) >> 8) / 255.0
        let blue = Double(color & 0x0000FF) / 255.0
                
        self.init(red: red, green: green, blue: blue)
    }
}
