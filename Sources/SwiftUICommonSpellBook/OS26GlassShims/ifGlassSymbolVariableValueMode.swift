//
//  ifGlassSymbolVariableValueMode.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
extension View {
    @available(iOS, obsoleted: 26, renamed: "symbolVariableValueMode(_:)")
    @available(macOS, obsoleted: 26, renamed: "symbolVariableValueMode(_:)")
    @available(macCatalyst, obsoleted: 26, renamed: "symbolVariableValueMode(_:)")
    @available(tvOS, obsoleted: 26, renamed: "symbolVariableValueMode(_:)")
    @available(watchOS, obsoleted: 26, renamed: "symbolVariableValueMode(_:)")
    @available(visionOS, obsoleted: 26, renamed: "symbolVariableValueMode(_:)")
    @ViewBuilder
    public func ifGlassSymbolVariableValueMode(_ mode: SymbolVariableValueMode?) -> some View {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.symbolVariableValueMode(mode?.swiftUIValue)
        } else {
            self
        }
    }
}
#else
extension View {
    public func ifGlassSymbolVariableValueMode(_ mode: SymbolVariableValueMode?) -> some View {
        self
    }
}
#endif
