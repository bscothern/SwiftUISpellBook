//
//  IfGlassGlassEffectID.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/14/25.
//

import SwiftUI

extension View {
    @inlinable
    @ViewBuilder
    public nonisolated func ifGlassGlassEffectID(
        _ id: (some Hashable & Sendable)?,
        in namespace: Namespace.ID
    ) -> some View {
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.glassEffectID(id, in: namespace)
        } else {
            self
        }
    }
}
