//
//  ifGlassSymbolColorRenderingMode.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
extension View {
    @available(iOS, obsoleted: 26, renamed: "symbolColorRenderingMode(_:)")
    @available(macOS, obsoleted: 26, renamed: "symbolColorRenderingMode(_:)")
    @available(tvOS, obsoleted: 26, renamed: "symbolColorRenderingMode(_:)")
    @available(watchOS, obsoleted: 26, renamed: "symbolColorRenderingMode(_:)")
    @available(visionOS, obsoleted: 26, renamed: "symbolColorRenderingMode(_:)")
    @ViewBuilder
    public func ifGlassSymbolColorRenderingMode(_ mode: SymbolColorRenderingMode?) -> some View {
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.symbolColorRenderingMode(mode?.swiftUIValue)
        } else {
            self
        }
    }
}
#else
extension View {
    public func ifGlassSymbolColorRenderingMode(_ mode: SymbolColorRenderingMode?) -> some View {
        self
    }
}
#endif
