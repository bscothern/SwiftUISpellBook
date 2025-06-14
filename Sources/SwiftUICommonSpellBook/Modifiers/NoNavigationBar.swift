//
//  NoNavigationBar.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/4/20.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
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

    @ViewBuilder
    @usableFromInline
    func body(content: Content) -> some View {
        #if os(macOS)
        content
        #else
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            content
                .toolbarVisibility(.hidden, for: .navigationBar)
        } else if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            content
                .toolbar(.hidden, for: .navigationBar)
        } else {
            content
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
        #endif
    }
}
