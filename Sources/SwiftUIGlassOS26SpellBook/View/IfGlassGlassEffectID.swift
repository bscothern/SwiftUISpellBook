//
//  IfGlassGlassEffectID.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/14/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
extension View {
    @available(iOS, obsoleted: 26, renamed: "glassEffectID(_:in:)")
    @available(macOS, obsoleted: 26, renamed: "glassEffectID(_:in:)")
    @available(macCatalyst, obsoleted: 26, renamed: "glassEffectID(_:in:)")
    @available(tvOS, obsoleted: 26, renamed: "glassEffectID(_:in:)")
    @available(watchOS, obsoleted: 26, renamed: "glassEffectID(_:in:)")
    @available(visionOS, obsoleted: 26, renamed: "glassEffectID(_:in:)")
    @inlinable
    @ViewBuilder
    public nonisolated func ifGlassGlassEffectID(
        _ id: (some Hashable & Sendable)?,
        in namespace: Namespace.ID
    ) -> some View {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.glassEffectID(id, in: namespace)
        } else {
            self
        }
    }
}
#else
extension View {
    @inlinable
    @ViewBuilder
    public nonisolated func ifGlassGlassEffectID(
        _ id: (some Hashable & Sendable)?,
        in namespace: Namespace.ID
    ) -> some View {
        self
    }
}
#endif
