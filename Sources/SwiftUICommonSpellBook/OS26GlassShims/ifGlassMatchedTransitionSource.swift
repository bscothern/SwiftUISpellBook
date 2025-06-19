//
//  ifGlassMatchedTransitionSource.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(iOS 16, tvOS 16, macCatalyst 16, *)
extension ToolbarContent {
    @available(iOS, obsoleted: 26, renamed: "matchedTransitionSource(id:in:)")
    @available(macCatalyst, obsoleted: 26, renamed: "matchedTransitionSource(id:in:)")
    @available(tvOS, obsoleted: 26, renamed: "matchedTransitionSource(id:in:)")
    @ToolbarContentBuilder
    public func ifGlassMatchedTransitionSource(id: some Hashable, in namespace: Namespace.ID) -> some ToolbarContent {
        if #available(iOS 26, tvOS 26, macCatalyst 26, *) {
            self.matchedTransitionSource(id: id, in: namespace)
        } else {
            self
        }
    }
}
#else
extension ToolbarContent {
    public func ifGlassMatchedTransitionSource(id: some Hashable, in namespace: Namespace.ID) -> some ToolbarContent {
        self
    }
}
#endif
