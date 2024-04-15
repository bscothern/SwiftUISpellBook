//
//  StackOrDoubleColumnNavigationViewStyle.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/4/20.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    /// Dynamically swap between `StackNavigationViewStyle` and `DoubleColumnNavigationViewStyle` depending on if there is room for multiple columns or not.
    ///
    /// - Note:
    ///     This is driven by `@Environment(\.horizontalSizeClass)`.
    ///     When it is `.regular` then `DoubleColumnNavigationViewStyle` will be used and when it is `.compact` then `StackNavigationViewStyle` will be used.
    ///
    /// - Returns: The `View` with its navigation style dynamically set according to the screen size.
    @inlinable
    public func stackOrDoubleColumnNavigationViewStyle() -> some View {
        modifier(StackOrDoubleColumnNavigationViewStyleViewMoifier())
    }
}

@usableFromInline
struct StackOrDoubleColumnNavigationViewStyleViewMoifier: ViewModifier {
    #if !os(macOS)
    @usableFromInline
    @Environment(\.horizontalSizeClass)
    var horizontalSizeClass: UserInterfaceSizeClass?
    #endif

    @usableFromInline
    init() {}

    @usableFromInline
    @ViewBuilder
    func body(content: Content) -> some View {
        #if !os(macOS)
        if horizontalSizeClass == .regular {
            content
                .navigationViewStyle(DoubleColumnNavigationViewStyle())
                .environment(\.stackOrDoubleColumnMode, .doubleColumn)
        } else {
            content
                .navigationViewStyle(StackNavigationViewStyle())
                .environment(\.stackOrDoubleColumnMode, .stack)
        }
        #else
        content
            .navigationViewStyle(DoubleColumnNavigationViewStyle())
            .environment(\.stackOrDoubleColumnMode, .doubleColumn)
        #endif
    }
}

public enum StackOrDoubleColumnMode {
    case stack
    case doubleColumn
}

@usableFromInline
enum StackOrDoubleColumnModeEnvironmentKey: EnvironmentKey {
    public static let defaultValue: StackOrDoubleColumnMode? = nil
}

extension EnvironmentValues {
    @inlinable
    public var stackOrDoubleColumnMode: StackOrDoubleColumnMode? {
        get { self[StackOrDoubleColumnModeEnvironmentKey.self] }
        set { self[StackOrDoubleColumnModeEnvironmentKey.self] = newValue }
    }
}
