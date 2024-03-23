//
//  NavigationBarHidden.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/18/21.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

#if os(macOS)
extension View {
    @inlinable
    public func navigationBarHidden(_: Bool) -> some View {
        self
    }
}
#endif
