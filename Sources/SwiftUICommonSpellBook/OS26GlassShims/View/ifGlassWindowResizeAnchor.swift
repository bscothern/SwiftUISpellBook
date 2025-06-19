//
//  ifGlassWindowResizeAnchor.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(macCatalyst, unavailable)
extension View {
    @available(macOS, obsoleted: 26, renamed: "windowResizeAnchor(_:)")
    @ViewBuilder
    public func ifGlassWindowResizeAnchor(_ anchor: UnitPoint?) -> some View {
        if #available(macOS 26, *) {
            self.windowResizeAnchor(anchor)
        } else {
            self
        }
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
