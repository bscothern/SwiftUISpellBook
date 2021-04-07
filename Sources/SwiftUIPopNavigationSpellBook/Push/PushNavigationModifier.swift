//
//  PushNavigationModifier.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/9/20.
//  Copyright © 2020-2021 Braden Scothern. All rights reserved.
//

import SwiftUI

public extension View {
    /// Binds the pushing of a `Destination` to a `Bool`.
    ///
    /// - Important: `trigger` will be reset to false when `destination` disappears.
    ///     This is to prevent instantly pushing `destination` again.
    ///
    /// - Parameters:
    ///   - destination: The view that should be pushed when `trigger` is bound to a `true` value.
    ///   - trigger: A `Binding<Bool>` that determines if `destination` should be pushed.
    @inlinable
    func pushNavigation<Destination>(to destination: Destination, when trigger: Binding<Bool>) -> some View where Destination: View {
        modifier(PushNavigationModifier(destination: destination, trigger: trigger))
    }
}

@usableFromInline
struct PushNavigationModifier<Destination>: ViewModifier where Destination: View {
    @usableFromInline
    let destination: Destination

    // Can this actually be @usableFromInline?
    @usableFromInline
    @Binding
    var trigger: Bool

    @usableFromInline
    init(destination: Destination, trigger: Binding<Bool>) {
        self.destination = destination
        self._trigger = trigger
    }

    @usableFromInline
    func body(content: Content) -> some View {
        content
            .background(
                PopNavigationLink(
                    destination: destination
                        .onDisappear {
                            self.trigger = false
                        },
                    isActive: $trigger) {
                        EmptyView()
                }
            )
    }
}
