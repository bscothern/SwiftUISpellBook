//
//  PopNavigationState.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/3/20.
//  Copyright © 2019-2021 Braden Scothern. All rights reserved.
//

import SwiftUI

// TODO: Support multiple instances so it can be used in multiple windows?
@usableFromInline
final class PopNavigationState {
    @usableFromInline
    static let shared = PopNavigationState(popCount: 0)

    @usableFromInline
    var popCount: Int

    @usableFromInline
    init(popCount: Int = 0) {
        self.popCount = popCount
    }
}
