//
//  Color+UIColor.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/4/20.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
extension Color {
    private typealias UIColorType = UIColor
}

#elseif canImport(AppKit)
import AppKit
extension Color {
    private typealias UIColorType = NSColor
}

#endif

@available(iOS 14.0, *)
@available(macCatalyst 14.0, *)
@available(macOS 10.16, *)
@available(watchOS 7, *)
@available(tvOS 14.0, *)
extension Color {
    func rgbaColorSpaceComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let uiColor = UIColorType(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }

    func hsbColorSpaceComponents() -> (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        let uiColor = UIColorType(self)
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return (hue, saturation, brightness, alpha)
    }
}
