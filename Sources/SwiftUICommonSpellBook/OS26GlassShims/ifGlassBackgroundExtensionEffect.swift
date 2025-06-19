//
//  ifGlassBackgroundExtensionEffect.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/15/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
extension View {
    @available(iOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(macOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(macCatalyst, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(tvOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(watchOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(visionOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @inlinable
    @ViewBuilder
    public func ifGlassBackgroundExtensionEffect() -> some View {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.backgroundExtensionEffect()
        } else {
            self
        }
    }
}
#else
extension View {
    @inlinable
    @ViewBuilder
    public func ifGlassBackgroundExtensionEffect() -> some View {
        self
    }
}
#endif
