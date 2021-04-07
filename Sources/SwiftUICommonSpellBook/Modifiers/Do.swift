//
//  Do.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/28/21.
//  Copyright © 2020-2021 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    @inlinable
    public func `do`(_ work: () -> Void) -> Self {
        work()
        return self
    }
}
