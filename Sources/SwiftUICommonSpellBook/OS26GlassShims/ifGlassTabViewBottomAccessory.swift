//
//  ifGlassTabViewBottomAccessory.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
extension View {
    @available(iOS, obsoleted: 26, renamed: "tabViewBottomAccessory(content:)")
    @available(macOS, obsoleted: 26, renamed: "tabViewBottomAccessory(content:)")
    @available(tvOS, obsoleted: 26, renamed: "tabViewBottomAccessory(content:)")
    @available(watchOS, obsoleted: 26, renamed: "tabViewBottomAccessory(content:)")
    @available(visionOS, obsoleted: 26, renamed: "tabViewBottomAccessory(content:)")
    @ViewBuilder
    public func ifGlassTabViewBottomAccessory<Content>(
        @ViewBuilder content: () -> Content
    ) -> some View
    where Content: View {
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.tabViewBottomAccessory(content: content)
        } else {
            self
        }
    }
}
#else
extension View {
    public func ifGlassTabViewBottomAccessory<Content>(
        @ViewBuilder content: () -> Content
    ) -> some View
    where Content: View {
        self
    }
}
#endif
