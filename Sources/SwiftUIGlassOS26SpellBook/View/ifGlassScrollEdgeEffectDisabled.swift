//
//  ifGlassScrollEdgeEffectDisabled.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
extension View {
    @available(iOS, obsoleted: 26, renamed: "scrollEdgeEffectStyle(_:for:)")
    @available(macOS, obsoleted: 26, renamed: "scrollEdgeEffectStyle(_:for:)")
    @available(macCatalyst, obsoleted: 26, renamed: "scrollEdgeEffectStyle(_:for:)")
    @available(tvOS, obsoleted: 26, renamed: "scrollEdgeEffectStyle(_:for:)")
    @available(watchOS, obsoleted: 26, renamed: "scrollEdgeEffectStyle(_:for:)")
    @available(visionOS, obsoleted: 26, renamed: "scrollEdgeEffectStyle(_:for:)")
    @ViewBuilder
    public func ifGlassScrollEdgeEffectDisabled(_ disabled: Bool = true, for edges: Edge.Set = .all) -> some View {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.scrollEdgeEffectDisabled(disabled, for: edges)
        } else {
            self
        }
    }
}
#else
extension View {
    public func ifGlassScrollEdgeEffectDisabled(_ disabled: Bool = true, for edges: Edge.Set = .all) -> some View {
        self
    }
}
#endif
