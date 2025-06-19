//
//  ifGlassWindowResizeAnchor.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity

extension View {
    @available(iOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    @available(macCatalyst, unavailable)
    @available(macOS, obsoleted: 26, renamed: "windowResizeAnchor(_:)")
    @ViewBuilder
    public func ifGlassWindowResizeAnchor(_ anchor: UnitPoint?) -> some View {
        #if os(macOS)
        if #available(macOS 26.0, *) {
            self.windowResizeAnchor(anchor)
        } else {
            self
        }
        #else
        self
        #endif
    }
}
#else
@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(macCatalyst, unavailable)
extension View {
    public func ifGlassWindowResizeAnchor(_ anchor: UnitPoint?) -> some View {
        self
    }
}
#endif
