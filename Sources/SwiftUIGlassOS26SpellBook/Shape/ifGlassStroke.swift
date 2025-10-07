//
//  ifGlassStroke.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/20/25.
//

import SwiftUI

extension Shape {
    @ViewBuilder
    public func ifNoGlassStroke<S>(
        _ content: S,
        lineWidth: CGFloat = 1
    ) -> some View
    where S: ShapeStyle {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self
        } else {
            self.stroke(content, lineWidth: lineWidth)
        }
    }
    
    @ViewBuilder
    public func isGlassStroke<S>(
        _ content: S,
        lineWidth: CGFloat = 1
    ) -> some View
    where S: ShapeStyle {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.stroke(content, lineWidth: lineWidth)
        } else {
            self
        }
    }
    
    @ViewBuilder
    public func ifNoGlassStroke(
        lineWidth: CGFloat = 1
    ) -> some View {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self
        } else {
            self.stroke(lineWidth: lineWidth)
        }
    }
    
    @ViewBuilder
    public func isGlassStroke(
        lineWidth: CGFloat = 1
    ) -> some View  {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            self.stroke(lineWidth: lineWidth)
        } else {
            self
        }
    }
}
