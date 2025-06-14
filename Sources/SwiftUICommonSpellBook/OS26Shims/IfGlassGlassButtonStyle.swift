//
//  GlassButtonStyle.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/14/25.
//

import SwiftUI

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

extension View {
    @inlinable
    @_disfavoredOverload
    @ViewBuilder
    public func buttonStyle<ElseStyle>(_ buttonStyle: IfGlassGlassButtonStyle<ElseStyle>) -> some View where ElseStyle: PrimitiveButtonStyle {
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.buttonStyle(.glass)
        } else {
            self.buttonStyle(buttonStyle.elseStyle)
        }
    }
}
