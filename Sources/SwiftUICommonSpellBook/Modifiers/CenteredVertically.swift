//
//  CenteredVertically.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 4/22/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    @inlinable
    public func centeredVertically() -> some View {
        modifier(CenteredVertically())
    }
}

@usableFromInline
struct CenteredVertically: ViewModifier {
    @usableFromInline
    init() {}
    
    @usableFromInline
    func body(content: Content) -> some View {
        VStack {
            Spacer()
            content
            Spacer()
        }
    }
}
