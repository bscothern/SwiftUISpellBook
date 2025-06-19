//
//  ifGlassMultilineTextAlignment.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
extension View {
    @available(iOS, obsoleted: 26, renamed: "multilineTextAlignment(strategy:)")
    @available(macOS, obsoleted: 26, renamed: "multilineTextAlignment(strategy:)")
    @available(macCatalyst, obsoleted: 26, renamed: "multilineTextAlignment(strategy:)")
    @available(tvOS, obsoleted: 26, renamed: "multilineTextAlignment(strategy:)")
    @available(watchOS, obsoleted: 26, renamed: "multilineTextAlignment(strategy:)")
    @available(visionOS, obsoleted: 26, renamed: "multilineTextAlignment(strategy:)")
    @ViewBuilder
    public func ifGlassMultilineTextAlignment(strategy: TextAlignmentStrategy) -> some View {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.multilineTextAlignment(strategy: strategy.swiftUIValue)
        } else {
            self
        }
    }
}
#else
extension View {
    public func ifGlassMultilineTextAlignment(strategy: TextAlignmentStrategy) -> some View {
        self
    }
}
#endif
