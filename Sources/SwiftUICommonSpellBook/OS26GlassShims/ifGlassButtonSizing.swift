//
//  ifGlassButtonSizing.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI



#if swift(>=6.2) || GlassCompatibliity
extension View {
    @ViewBuilder
    public func ifGlassButtonSizing(_ sizing: ButtonSizing) -> some View {
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.buttonSizing(sizing.swiftUIValue)
        } else {
            self
        }
    }
}
#else
extension View {
    public func ifGlassButtonSizing(_ sizing: ButtonSizing) -> some View {
        self
    }
}
#endif
