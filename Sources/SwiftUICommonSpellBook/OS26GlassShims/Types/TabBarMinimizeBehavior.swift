//
//  TabBarMinimizeBehavior.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/15/25.
//

import SwiftUI

@available(iOS, obsoleted: 26)
@available(macOS, obsoleted: 26)
@available(macCatalyst, obsoleted: 26)
@available(tvOS, obsoleted: 26)
@available(watchOS, obsoleted: 26)
@available(visionOS, obsoleted: 26)
public struct TabBarMinimizeBehavior: Hashable, Sendable {
    @usableFromInline
    enum Value: Hashable, Sendable {
        case automatic
        case onScrollDown
        case onScrollUp
        case never
    }

    @usableFromInline
    let value: Value

    @usableFromInline
    init(value: Value) {
        self.value = value
    }

    #if swift(>=6.2) || GlassCompatibliity
    @available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *)
    @usableFromInline
    var swiftUIValue: SwiftUI.TabBarMinimizeBehavior {
        switch self.value {
        case .automatic:
            .automatic
        case .onScrollDown:
            #if os(macOS)
            fatalError()
            #else
            .onScrollDown
            #endif
        case .onScrollUp:
            #if os(macOS)
            fatalError()
            #else
            .onScrollUp
            #endif
        case .never:
            #if os(macOS)
            fatalError()
            #else
            .never
            #endif
        }
    }
    #endif

    public static let automatic = TabBarMinimizeBehavior(value: .automatic)

    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    public static let onScrollDown = TabBarMinimizeBehavior(value: .onScrollDown)

    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    public static let onScrollUp = TabBarMinimizeBehavior(value: .onScrollUp)

    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    public static let never = TabBarMinimizeBehavior(value: .never)
}
