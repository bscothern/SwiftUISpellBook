//
//  RemoveListBackground.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/10/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    @inlinable
    public func removeListBackground() -> some View {
        modifier(RemoveListBackground())
    }
}

@usableFromInline
struct RemoveListBackground: ViewModifier {
    @usableFromInline
    init() {}

    @usableFromInline
    func body(content: Content) -> some View {
        content
            .listRowBackground(EmptyView())
    }
}
