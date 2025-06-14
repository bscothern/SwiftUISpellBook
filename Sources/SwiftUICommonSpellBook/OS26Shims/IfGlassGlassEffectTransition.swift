//
//  IfGlassGlassEffectTransition.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/14/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
extension View {
    @inlinable
    @ViewBuilder
    public func ifGlassGlassEffectTransition(_ transition: GlassEffectTransition, isEnabled: Bool = true) -> some View {
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *),
           let transition = transition.value as? SwiftUI.GlassEffectTransition {
            self.glassEffectTransition(transition, isEnabled: isEnabled)
        } else {
            self
        }
    }
}
#else
extension View {
    @inlinable
    @ViewBuilder
    public func ifGlassGlassEffectTransition(_ transition: GlassEffectTransition, isEnabled: Bool = true) -> some View {
        self
    }
}
#endif
