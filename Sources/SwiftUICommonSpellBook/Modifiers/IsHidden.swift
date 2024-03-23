//
//  IsHidden.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/30/21.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    /// Lets you control if a view is hidden or shown.
    ///
    /// Hidden views are invisible and can’t receive or respond to interactions.
    ///
    /// - Parameter isHidden: If the view should be hidden.
    @inlinable
    public func hidden(_ isHidden: Bool) -> some View {
        self.opacity(isHidden ? 0.0 : 1.0)
    }
}
