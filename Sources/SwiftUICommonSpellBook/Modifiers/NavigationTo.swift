//
//  NavigationTo.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 11/23/20.
//  Copyright © 2020-2021 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    @inlinable
    public func navigationTo<Destination>(destination: Destination, isActive: Binding<Bool>) -> some View where Destination: View {
        modifier(NavigationToModifier(destination: destination, isActive: isActive))
    }
}

@usableFromInline
struct NavigationToModifier<Destination>: ViewModifier where Destination: View {
    @usableFromInline
    let destination: Destination

    @usableFromInline
    let isActive: Binding<Bool>

    @usableFromInline
    init(destination: Destination, isActive: Binding<Bool>) {
        self.destination = destination
        self.isActive = isActive
    }

    @usableFromInline
    func body(content: Content) -> some View {
        content.overlay {
            NavigationLink(
                destination: destination,
                isActive: isActive
            )
        }
    }
}
