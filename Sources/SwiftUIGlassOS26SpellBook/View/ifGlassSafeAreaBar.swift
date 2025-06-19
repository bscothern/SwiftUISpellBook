//
//  ifGlassSafeAreaBar.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
extension View {
    @available(iOS, obsoleted: 26, renamed: "safeAreaBar(edge:alignment:spacing:content:)")
    @available(macOS, obsoleted: 26, renamed: "safeAreaBar(edge:alignment:spacing:content:)")
    @available(macCatalyst, obsoleted: 26, renamed: "safeAreaBar(edge:alignment:spacing:content:)")
    @available(tvOS, obsoleted: 26, renamed: "safeAreaBar(edge:alignment:spacing:content:)")
    @available(watchOS, obsoleted: 26, renamed: "safeAreaBar(edge:alignment:spacing:content:)")
    @available(visionOS, obsoleted: 26, renamed: "safeAreaBar(edge:alignment:spacing:content:)")
    @ViewBuilder
    public func ifGlassSafeAreaBar(
        edge: HorizontalEdge,
        alignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        @ViewBuilder content: () -> some View
    ) -> some View {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.safeAreaBar(edge: edge, alignment: alignment, spacing: spacing, content: content)
        } else {
            self
        }
    }

    @available(iOS, obsoleted: 26, renamed: "safeAreaBar(edge:alignment:spacing:content:)")
    @available(macOS, obsoleted: 26, renamed: "safeAreaBar(edge:alignment:spacing:content:)")
    @available(macCatalyst, obsoleted: 26, renamed: "safeAreaBar(edge:alignment:spacing:content:)")
    @available(tvOS, obsoleted: 26, renamed: "safeAreaBar(edge:alignment:spacing:content:)")
    @available(watchOS, obsoleted: 26, renamed: "safeAreaBar(edge:alignment:spacing:content:)")
    @available(visionOS, obsoleted: 26, renamed: "safeAreaBar(edge:alignment:spacing:content:)")
    @ViewBuilder
    public func ifGlassSafeAreaBar(
        edge: VerticalEdge,
        alignment: HorizontalAlignment = .center,
        spacing: CGFloat? = nil,
        @ViewBuilder content: () -> some View
    ) -> some View {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.safeAreaBar(edge: edge, alignment: alignment, spacing: spacing, content: content)
        } else {
            self
        }
    }
}
#else
extension View {
    public func ifGlassSafeAreaBar(
        edge: HorizontalEdge,
        alignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        @ViewBuilder content: () -> some View
    ) -> some View {
        self
    }

    public func ifGlassSafeAreaBar(
        edge: VerticalEdge,
        alignment: HorizontalAlignment = .center,
        spacing: CGFloat? = nil,
        @ViewBuilder content: () -> some View
    ) -> some View {
        self
    }
}
#endif
