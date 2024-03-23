//
//  GradientMask.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/4/20.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    /// Masks a view with a gradient.
    ///
    /// - Parameter linearGradient: The gradient to apply with the mask.
    @inlinable
    public func gradientMask(_ linearGradient: LinearGradient) -> some View {
        modifier(GradientMaskModifier(linearGradient: linearGradient))
    }
}

@usableFromInline
struct GradientMaskModifier: ViewModifier {
    @usableFromInline
    let linearGradient: LinearGradient
    
    @usableFromInline
    init(linearGradient: LinearGradient) {
        self.linearGradient = linearGradient
    }
    

    @usableFromInline
    func body(content: Content) -> some View {
        content
            .overlay(linearGradient)
            .mask(content)
    }
}
