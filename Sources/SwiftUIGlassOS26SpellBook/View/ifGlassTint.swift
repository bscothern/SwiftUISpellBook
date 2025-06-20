//
//  ifGlassTint.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/15/25.
//

import SwiftUI

extension View {
    @available(iOS, obsoleted: 26, renamed: "tint(_:)")
    @available(macOS, obsoleted: 26, renamed: "tint(_:)")
    @available(macCatalyst, obsoleted: 26, renamed: "tint(_:)")
    @available(tvOS, obsoleted: 26, renamed: "tint(_:)")
    @available(watchOS, obsoleted: 26, renamed: "tint(_:)")
    @available(visionOS, obsoleted: 26, renamed: "tint(_:)")
    @inlinable
    @ViewBuilder
    public func ifGlassTint(_ tint: Color?) -> some View {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.tint(tint)
        } else {
            self
        }
    }

    @available(iOS, obsoleted: 26, renamed: "tint(_:)")
    @available(macOS, obsoleted: 26, renamed: "tint(_:)")
    @available(macCatalyst, obsoleted: 26, renamed: "tint(_:)")
    @available(tvOS, obsoleted: 26, renamed: "tint(_:)")
    @available(watchOS, obsoleted: 26, renamed: "tint(_:)")
    @available(visionOS, obsoleted: 26, renamed: "tint(_:)")
    @inlinable
    @ViewBuilder
    public func ifGlassTintOtherwiseForegroundStyle(_ tint: Color?) -> some View {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.tint(tint)
        } else if let tint {
            self.foregroundStyle(tint)
        } else {
            self
        }
    }

    @available(iOS, obsoleted: 26, renamed: "tint(_:)")
    @available(macOS, obsoleted: 26, renamed: "tint(_:)")
    @available(macCatalyst, obsoleted: 26, renamed: "tint(_:)")
    @available(tvOS, obsoleted: 26, renamed: "tint(_:)")
    @available(watchOS, obsoleted: 26, renamed: "tint(_:)")
    @available(visionOS, obsoleted: 26, renamed: "tint(_:)")
    @inlinable
    @ViewBuilder
    public func ifNoGlassTint(_ tint: Color?) -> some View {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self
        } else {
            self.tint(tint)
        }
    }
}
