//
//  IfGlassGlassEffectContainer.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/14/25.
//

import SwiftUI

@available(iOS, obsoleted: 26, renamed: "GlassEffectContainer")
@available(macOS, obsoleted: 26, renamed: "GlassEffectContainer")
@available(tvOS, obsoleted: 26, renamed: "GlassEffectContainer")
@available(watchOS, obsoleted: 26, renamed: "GlassEffectContainer")
@available(visionOS, obsoleted: 26, renamed: "GlassEffectContainer")
public struct IfGlassGlassEffectContainer<Content: View>: View, Sendable {
    @usableFromInline
    var spacing: CGFloat?
    
    @usableFromInline
    var content: @Sendable () -> Content

    @inlinable
    public var body: some View {
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *) {
            GlassEffectContainer(spacing: spacing, content: content)
        } else {
            content()
        }
    }

    @inlinable
    public init(
        spacing: CGFloat? = nil,
        @ViewBuilder content: @escaping @Sendable () -> Content
    ) {
        self.spacing = spacing
        self.content = content
    }
}
