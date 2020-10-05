//
//  NoNavigationBar.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/4/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    /// Force the navigation bar to hide by clearing its title and going to a hidden state.
    @inlinable
    public func noNavigationBar() -> some View {
        modifier(NoNavigationbarModifier())
    }
}

@usableFromInline
struct NoNavigationbarModifier: ViewModifier {
    @usableFromInline
    init() {}

    @usableFromInline
    func body(content: Content) -> some View {
        content
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}
