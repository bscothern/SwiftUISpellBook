//
//  Text.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 4/16/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

extension Text {
    @inlinable
    public init(_ betterLocalizedStringKey: BetterLocalizedStringKey) {
        self.init(
            betterLocalizedStringKey.localizedStringKey,
            tableName: betterLocalizedStringKey.tableName,
            bundle: betterLocalizedStringKey.bundle,
            comment: betterLocalizedStringKey.comment
        )
    }
}
