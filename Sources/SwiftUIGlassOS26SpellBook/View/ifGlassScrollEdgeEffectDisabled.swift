//
//  ifGlassScrollEdgeEffectDisabled.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
extension View {
    @available(iOS, obsoleted: 26, renamed: "scrollEdgeEffectHidden(_:for:)")
    @available(macOS, obsoleted: 26, renamed: "scrollEdgeEffectHidden(_:for:)")
    @available(macCatalyst, obsoleted: 26, renamed: "scrollEdgeEffectHidden(_:for:)")
    @available(tvOS, obsoleted: 26, renamed: "scrollEdgeEffectHidden(_:for:)")
    @available(watchOS, obsoleted: 26, renamed: "scrollEdgeEffectHidden(_:for:)")
    @available(visionOS, obsoleted: 26, renamed: "scrollEdgeEffectHidden(_:for:)")
    @ViewBuilder
    public func ifGlassScrollEdgeEffectHidden(_ disabled: Bool = true, for edges: Edge.Set = .all) -> some View {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.scrollEdgeEffectHidden(disabled, for: edges)
        } else {
            self
        }
    }
}
#else
extension View {
    public func ifGlassScrollEdgeEffectHidden(_ disabled: Bool = true, for edges: Edge.Set = .all) -> some View {
        self
    }
}
#endif
