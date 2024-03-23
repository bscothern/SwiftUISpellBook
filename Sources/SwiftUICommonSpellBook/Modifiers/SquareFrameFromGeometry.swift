//
//  SquareFrameFromGeometry.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/9/20.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    @inlinable
    public func squareFrameFromGeometry(max: CGFloat = .infinity, alignment: Alignment = .center) -> some View {
        modifier(SquareFrameFromGeometryModifier(max: max, alignment: alignment))
    }
}

@usableFromInline
struct SquareFrameFromGeometryModifier: ViewModifier {
    @usableFromInline
    let max: CGFloat

    @usableFromInline
    let alignment: Alignment
    
    @usableFromInline
    init(max: CGFloat, alignment: Alignment) {
        self.max = max
        self.alignment = alignment
    }

    @usableFromInline
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                self.frame(content, in: geometry)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: self.alignment)
        }
    }

    @usableFromInline
    func frame(_ content: Content, in geometry: GeometryProxy) -> some View {
        let size = min(geometry.size.width, geometry.size.height, max)
        return content
            .frame(width: size, height: size)
    }
}
