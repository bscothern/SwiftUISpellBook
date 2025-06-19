//
//  ifGlassSearchToolbarBehavior.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
extension View {
    @available(iOS, obsoleted: 26, renamed: "searchToolbarBehavior(_:)")
    @available(macOS, obsoleted: 26, renamed: "searchToolbarBehavior(_:)")
    @available(macCatalyst, obsoleted: 26, renamed: "searchToolbarBehavior(_:)")
    @available(tvOS, obsoleted: 26, renamed: "searchToolbarBehavior(_:)")
    @available(watchOS, obsoleted: 26, renamed: "searchToolbarBehavior(_:)")
    @available(visionOS, obsoleted: 26, renamed: "searchToolbarBehavior(_:)")
    @ViewBuilder
    public func ifGlassSearchToolbarBehavior(_ behavior: SearchToolbarBehavior) -> some View {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.searchToolbarBehavior(behavior.swiftUIValue)
        } else {
            self
        }
    }
}
#else
extension View {
    public func ifGlassSearchToolbarBehavior(_ behavior: SearchToolbarBehavior) -> some View {
        self
    }
}
#endif
