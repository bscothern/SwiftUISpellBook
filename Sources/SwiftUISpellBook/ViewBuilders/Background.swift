//
//  Background.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/4/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    @inlinable
    public func background<BackgroundContent>(@ViewBuilder _ background: () -> BackgroundContent) -> some View
    where BackgroundContent: View {
        modifier(BuildBackgroundModiier(background()))
    }
}

@usableFromInline
struct BuildBackgroundModiier<BackgroundContent>: ViewModifier
where BackgroundContent: View {
    @usableFromInline
    let backgroundContent: BackgroundContent

    @usableFromInline
    init(_ backgroundContent: BackgroundContent) {
        self.backgroundContent = backgroundContent
    }

    @usableFromInline
    func body(content: Content) -> some View {
        content
            .background(backgroundContent)
    }
}
