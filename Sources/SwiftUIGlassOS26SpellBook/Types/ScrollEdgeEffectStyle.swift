//
//  ScrollEdgeEffectStyle.swift
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
public struct ScrollEdgeEffectStyle: Hashable, Sendable {
    enum Value: Sendable {
        case automatic
        case hard
        case soft
    }

    let value: Value

    public static let automatic: ScrollEdgeEffectStyle = .init(value: .automatic)
    public static let hard: ScrollEdgeEffectStyle = .init(value: .hard)
    public static let soft: ScrollEdgeEffectStyle = .init(value: .soft)

    #if swift(>=6.2) || GlassCompatibliity
    @available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *)
    var swiftUIValue: SwiftUI.ScrollEdgeEffectStyle {
        switch value {
        case .automatic:
            .automatic
        case .hard:
            .hard
        case .soft:
            .soft
        }
    }
    #endif
}
