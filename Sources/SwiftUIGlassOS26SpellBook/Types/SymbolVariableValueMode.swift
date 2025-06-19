//
//  SymbolVariableValueMode.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

@available(iOS, obsoleted: 26)
@available(macOS, obsoleted: 26)
@available(macCatalyst, obsoleted: 26)
@available(tvOS, obsoleted: 26)
@available(watchOS, obsoleted: 26)
@available(visionOS, obsoleted: 26)
public struct SymbolVariableValueMode: Hashable, Sendable {
    enum Value {
        case color
        case draw
    }

    let value: Value

    public static let color = Self(value: .color)
    public static let draw = Self(value: .draw)

    #if swift(>=6.2) || GlassCompatibliity
    @available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *)
    var swiftUIValue: SwiftUI.SymbolVariableValueMode {
        switch value {
        case .color:
            .color
        case .draw:
            .draw
        }
    }
    #endif
}
