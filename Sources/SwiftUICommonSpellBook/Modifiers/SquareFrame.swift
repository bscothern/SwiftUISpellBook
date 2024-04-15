//
//  SquareFrame.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/9/20.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    @inlinable
    public func squareFrame(size: CGSize, alignment: Alignment = .center) -> some View {
        squareFrame(size: min(size.width, size.height), alignment: alignment)
    }

    @inlinable
    public func squareFrame(size: CGFloat = .infinity, alignment: Alignment = .center) -> some View {
        modifier(SquareFrameModifier(size: size, alignment: alignment))
    }
}

@usableFromInline
struct SquareFrameModifier: ViewModifier {
    @usableFromInline
    let size: CGFloat

    @usableFromInline
    let alignment: Alignment

    @usableFromInline
    init(size: CGFloat, alignment: Alignment) {
        self.size = size
        self.alignment = alignment
    }

    @usableFromInline
    func body(content: Content) -> some View {
        content
            .frame(width: size, height: size, alignment: alignment)
    }
}
