//
//  PopNavigationPreferenceKey.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/3/20.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

@usableFromInline
struct PopNavigationPreferenceData: Equatable {
    @usableFromInline
    var popCount: Int
}

@usableFromInline
struct PopNavigationPreferenceKey: PreferenceKey {
    @usableFromInline
    typealias Value = PopNavigationPreferenceData

    @usableFromInline
    static var defaultValue = Value(popCount: 0)

    @usableFromInline
    static func reduce(value: inout Value, nextValue: () -> Value) {
        let next = nextValue()
        value.popCount = next.popCount
    }
}
