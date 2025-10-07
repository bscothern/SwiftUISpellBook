//
//  ifGlass.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 8/25/25.
//

import SwiftUI

extension View {
    @available(iOS, obsoleted: 26)
    @available(macOS, obsoleted: 26)
    @available(macCatalyst, obsoleted: 26)
    @available(tvOS, obsoleted: 26)
    @available(watchOS, obsoleted: 26)
    @available(visionOS, obsoleted: 26)
    @inlinable
    @ViewBuilder
    public func ifGlass(@ViewBuilder transform: (Self) -> some View) -> some View {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            transform(self)
        } else {
            self
        }
    }

    @available(iOS, obsoleted: 26)
    @available(macOS, obsoleted: 26)
    @available(macCatalyst, obsoleted: 26)
    @available(tvOS, obsoleted: 26)
    @available(watchOS, obsoleted: 26)
    @available(visionOS, obsoleted: 26)
    @inlinable
    @ViewBuilder
    public func ifNoGlass(@ViewBuilder transform: (Self) -> some View) -> some View {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self
        } else {
            transform(self)
        }
    }
}
