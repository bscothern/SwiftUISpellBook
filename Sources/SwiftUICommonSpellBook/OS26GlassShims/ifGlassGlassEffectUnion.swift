//
//  ifGlassGlassEffectUnion.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/14/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
extension View {
    @available(iOS, obsoleted: 26, renamed: "glassEffectUnion(id:namespace:)")
    @available(macOS, obsoleted: 26, renamed: "glassEffectUnion(id:namespace:)")
    @available(tvOS, obsoleted: 26, renamed: "glassEffectUnion(id:namespace:)")
    @available(watchOS, obsoleted: 26, renamed: "glassEffectUnion(id:namespace:)")
    @available(visionOS, obsoleted: 26, renamed: "glassEffectUnion(id:namespace:)")
    @MainActor
    @preconcurrency
    @inlinable
    @ViewBuilder
    public func ifGlassGlassEffectUnion(
        id: (some Hashable & Sendable)?,
        namespace: Namespace.ID
    ) -> some View {
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.glassEffectUnion(id: id, namespace: namespace)
        } else {
            self
        }
    }
}
#else
extension View {
    @MainActor
    @preconcurrency
    @inlinable
    @ViewBuilder
    public func ifGlassGlassEffectUnion(
        id: (some Hashable & Sendable)?,
        namespace: Namespace.ID
    ) -> some View {
        self
    }
}
#endif
