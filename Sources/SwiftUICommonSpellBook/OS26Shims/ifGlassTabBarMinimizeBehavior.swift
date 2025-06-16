//
//  ifGlassTabBarMinimizeBehavior.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/15/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
@available(iOS, obsoleted: 26, renamed: "tabBarMinimizeBehavior(_:)")
@available(macOS, obsoleted: 26, renamed: "tabBarMinimizeBehavior(_:)")
@available(tvOS, obsoleted: 26, renamed: "tabBarMinimizeBehavior(_:)")
@available(watchOS, obsoleted: 26, renamed: "tabBarMinimizeBehavior(_:)")
@available(visionOS, obsoleted: 26, renamed: "tabBarMinimizeBehavior(_:)")
extension View {
    @inlinable
    @ViewBuilder
    public func ifGlassTabBarMinimizeBehavior(_ behavior: TabBarMinimizeBehavior) -> some View {
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.tabBarMinimizeBehavior(behavior.swiftUIValue)
        } else {
            self
        }
    }
}
#else
extension View {
    @inlinable
    @ViewBuilder
    public func ifGlassTabBarMinimizeBehavior(_ behavior: TabBarMinimizeBehavior) -> some View {
        self
    }
}
#endif
