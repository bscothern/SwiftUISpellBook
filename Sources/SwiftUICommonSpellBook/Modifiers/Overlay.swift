//
//  Overlay.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 11/13/20.
//  Copyright © 2020-2021 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    @inlinable
    @_transparent
    public func overlay<Overlay>(@ViewBuilder _ overlay: () -> Overlay, alignment: Alignment = .center) -> some View where Overlay: View {
        self.overlay(overlay(), alignment: alignment)
    }
}
