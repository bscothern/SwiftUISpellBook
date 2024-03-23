//
//  FillSpace.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/4/20.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    /// The `View` should fill its containing view while ignoring all safe area guides.
    @inlinable
    public func fillSpace() -> some View {
        modifier(FillSpaceModifier())
    }
}

@usableFromInline
struct FillSpaceModifier: ViewModifier {
    @usableFromInline
    init() {}
    
    @usableFromInline
    func body(content: Content) -> some View {
        content
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
