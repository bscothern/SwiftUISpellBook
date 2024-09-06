//
//  InlineViewModifier.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/4/20.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

public struct InlineViewModifier<Body: View>: ViewModifier {
    @usableFromInline
    let inlinedModifier: @MainActor (Content) -> Body

    @inlinable
    public init(@ViewBuilder _ inlinedModifier: @escaping @MainActor (Content) -> Body) {
        self.inlinedModifier = inlinedModifier
    }

    public func body(content: Content) -> Body {
        inlinedModifier(content)
    }
}
