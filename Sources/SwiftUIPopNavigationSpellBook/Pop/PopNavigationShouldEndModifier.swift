//
//  PopNavigationShouldEnd.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/4/20.
//  Copyright © 2019-2021 Braden Scothern. All rights reserved.
//

import SwiftUI

public extension View {
    @inlinable
    func popNavigationShouldEnd(_ shouldEnd: Binding<Bool> = .init(get: { true }, set: { _ in })) -> some View {
        self.modifier(PopNavigationShouldEndModifer(shouldEnd))
    }
}

@usableFromInline
struct PopNavigationShouldEndModifer: ViewModifier {
    @usableFromInline
    @Binding
    var shouldEnd: Bool

    @usableFromInline
    init(_ shouldEnd: Binding<Bool>) {
        self._shouldEnd = shouldEnd
    }

    @usableFromInline
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard self.shouldEnd else { return }
                PopNavigationState.shared.popCount = 0
            }
    }
}
