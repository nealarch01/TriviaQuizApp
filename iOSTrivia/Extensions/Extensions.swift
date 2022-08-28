//
//  AppColors.swift
//  iOSTrivia
//
//  Created by Neal Archival on 8/26/22.
//

import SwiftUI

extension Color {
    public static let backgroundColor = Color("BackgroundColor")
    public static let contrastColor = Color("ContrastColor")
    
    // Custom initializer than accepts a hexadecimal
    init(hex: Int, opacity: Double = 1.0) {
        // Note: 0xff = 255
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

extension String {
    func base64Decode() -> String? {
        if let data = Data(base64Encoded: self, options: [.ignoreUnknownCharacters]) {
            return String(data: data, encoding: .utf16)
        }
        return nil
    }
}
