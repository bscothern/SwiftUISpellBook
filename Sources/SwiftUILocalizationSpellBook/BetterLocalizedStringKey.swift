//
//  Text.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 4/16/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import Foundation
import SwiftUI

public struct BetterLocalizedStringKey {
    @usableFromInline
    let localizedStringKey: LocalizedStringKey

    @usableFromInline
    let tableName: String?

    @usableFromInline
    let bundle: Bundle?

    @usableFromInline
    let comment: StaticString?

    @inlinable
    public init(_ localizedStringKey: LocalizedStringKey, tableName: String? = nil, bundle: Bundle? = nil, comment: StaticString? = nil) {
        self.localizedStringKey = localizedStringKey
        self.tableName = tableName
        self.bundle = bundle
        self.comment = comment
    }

    @inlinable
    public init(_ value: String, tableName: String? = nil, bundle: Bundle? = nil, comment: StaticString? = nil) {
        self.init(
            LocalizedStringKey(value),
            tableName: tableName,
            bundle: bundle,
            comment: comment
        )
    }
}

extension BetterLocalizedStringKey: Equatable {
    public static func == (lhs: BetterLocalizedStringKey, rhs: BetterLocalizedStringKey) -> Bool {
        lhs.localizedStringKey == rhs.localizedStringKey &&
        lhs.tableName == rhs.tableName &&
        lhs.bundle == rhs.bundle &&
        lhs.comment?.description == rhs.comment?.description
    }
}
