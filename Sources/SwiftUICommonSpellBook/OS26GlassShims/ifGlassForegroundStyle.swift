//
//  ifNoGlassForegroundStyle.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/14/25.
//

import SwiftUI

extension View {
    @available(iOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(macOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(macCatalyst, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(tvOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(watchOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(visionOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @inlinable
    @ViewBuilder
    public func ifGlassForegroundStyle<S>(_ style: S) -> some View where S: ShapeStyle {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.foregroundStyle(style)
        } else {
            self
        }
    }

    @available(iOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(macOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(macCatalyst, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(tvOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(watchOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(visionOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @inlinable
    @ViewBuilder
    public func ifGlassForegroundStyle<S1, S2>(_ style: S1, else elseStyle: S2) -> some View where S1: ShapeStyle, S2: ShapeStyle {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.foregroundStyle(style)
        } else {
            self.foregroundStyle(elseStyle)
        }
    }

    @available(iOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(macOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(macCatalyst, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(tvOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(watchOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @available(visionOS, obsoleted: 26, renamed: "foregroundStyle(_:)")
    @inlinable
    @ViewBuilder
    public func ifNoGlassForegroundStyle<S>(_ style: S) -> some View where S: ShapeStyle {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self
        } else {
            self.foregroundStyle(style)
        }
    }
}
