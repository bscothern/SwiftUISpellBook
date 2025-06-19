//
//  GlassButtonStyle.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/14/25.
//

import SwiftUI

@available(iOS, obsoleted: 26, renamed: "GlassButtonStyle")
@available(macOS, obsoleted: 26, renamed: "GlassButtonStyle")
@available(macCatalyst, obsoleted: 26, renamed: "GlassButtonStyle")
@available(tvOS, obsoleted: 26, renamed: "GlassButtonStyle")
@available(watchOS, obsoleted: 26, renamed: "GlassButtonStyle")
@available(visionOS, obsoleted: 26, renamed: "GlassButtonStyle")
public struct IfGlassGlassButtonStyle<ElseStyle: PrimitiveButtonStyle> {
    @usableFromInline
    let elseStyle: ElseStyle

    @inlinable
    public init(else elseStyle: ElseStyle) {
        self.elseStyle = elseStyle
    }
}

extension IfGlassGlassButtonStyle {
    @inlinable
    public static func glassOr(
        _ elseStyle: ElseStyle
    ) -> IfGlassGlassButtonStyle<ElseStyle>
    where ElseStyle: PrimitiveButtonStyle {
        IfGlassGlassButtonStyle(else: elseStyle)
    }
}

#if swift(>=6.2) || GlassCompatibliity
extension View {
    @available(iOS, obsoleted: 26)
    @available(macOS, obsoleted: 26)
    @available(macCatalyst, obsoleted: 26)
    @available(tvOS, obsoleted: 26)
    @available(watchOS, obsoleted: 26)
    @available(visionOS, obsoleted: 26)
    @inlinable
    @_disfavoredOverload
    @ViewBuilder
    public func buttonStyle<ElseStyle>(_ buttonStyle: IfGlassGlassButtonStyle<ElseStyle>) -> some View where ElseStyle: PrimitiveButtonStyle {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.buttonStyle(.glass)
        } else {
            self.buttonStyle(buttonStyle.elseStyle)
        }
    }
}
#else
extension View {
    @inlinable
    @_disfavoredOverload
    @ViewBuilder
    public func buttonStyle<ElseStyle>(_ buttonStyle: IfGlassGlassButtonStyle<ElseStyle>) -> some View where ElseStyle: PrimitiveButtonStyle {
        self.buttonStyle(buttonStyle.elseStyle)
    }
}
#endif
