//
//  IfGlassConcentricRectangle.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/7/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
@available(iOS, obsoleted: 26, renamed: "ConcentricRectangle()")
@available(macOS, obsoleted: 26, renamed: "ConcentricRectangle()")
@available(macCatalyst, obsoleted: 26, renamed: "ConcentricRectangle()")
@available(tvOS, obsoleted: 26, renamed: "ConcentricRectangle()")
@available(watchOS, obsoleted: 26, renamed: "ConcentricRectangle()")
@available(visionOS, obsoleted: 26, renamed: "ConcentricRectangle()")
public struct IfGlassConcentricRectangle: Shape {
    let cornerRadius: CGFloat?
    let cornerSize: CGSize?
    let style: RoundedCornerStyle

    public init(
        orRoundedCornerRadius cornerRadius: CGFloat,
        style: RoundedCornerStyle = .continuous
    ) {
        self.cornerRadius = cornerRadius
        self.cornerSize = nil
        self.style = style
    }

    public init(
        orRoundedCornerSize cornerSize: CGSize,
        style: RoundedCornerStyle = .continuous
    ) {
        self.cornerRadius = nil
        self.cornerSize = cornerSize
        self.style = style
    }

    public func path(in rect: CGRect) -> Path {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            return ConcentricRectangle().path(in: rect)
        } else if let cornerRadius {
            return RoundedRectangle(cornerRadius: cornerRadius, style: style).path(in: rect)
        } else if let cornerSize {
            return RoundedRectangle(cornerSize: cornerSize, style: style).path(in: rect)
        }
        return Path()
    }
}

#else
public struct IfGlassConcentricRectangle: Shape {
    let cornerRadius: CGFloat?
    let cornerSize: CGSize?
    let style: RoundedCornerStyle

    public init(
        orRoundedCornerRadius cornerRadius: CGFloat,
        style: RoundedCornerStyle = .continuous
    ) {
        self.cornerRadius = cornerRadius
        self.cornerSize = nil
        self.style = style
    }

    public init(
        orRoundedCornerSize cornerSize: CGSize,
        style: RoundedCornerStyle = .continuous
    ) {
        self.cornerRadius = nil
        self.cornerSize = cornerSize
        self.style = style
    }

    public func path(in rect: CGRect) -> Path {
        if let cornerRadius {
            return RoundedRectangle(cornerRadius: cornerRadius, style: style).path(in: rect)
        } else if let cornerSize {
            return RoundedRectangle(cornerSize: cornerSize, style: style).path(in: rect)
        }
        return Path()
    }
}
#endif
