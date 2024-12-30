//
//  Color+Extension.swift
//  Volatus
//
//  Created by Engin Gülek on 28.12.2024.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String, opacity: Double = 1.0) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    
  static  func calenderBackColor(type:DateValueType) -> String {
        switch type {
        case .now:
            ColorTheme.red.rawValue
        case .selected:
            ColorTheme.white.rawValue
        case .disable:
            ColorTheme.white.rawValue
        case .defaultDate:
            ColorTheme.white.rawValue
        }
    }
    
    
    static  func calenderDateColor(type:DateValueType) -> String {
        switch type {
        case .now:
            ColorTheme.white.rawValue
        case .selected:
            ColorTheme.black.rawValue
        case .disable:
            ColorTheme.gray.rawValue
        case .defaultDate:
            ColorTheme.black.rawValue
        }
    }
}
