//
//  Text.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 4/16/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import Foundation
import SwiftUI

public struct BetterLocalizedStringKey: Sendable {
    public let localizedStringKey: LocalizedStringKey
    public let tableName: String?
    public let bundle: Bundle?
    public let comment: StaticString?

    @inlinable
    public init(
        _ localizedStringKey: LocalizedStringKey,
        tableName: String? = nil,
        bundle: Bundle? = nil,
        comment: StaticString? = nil
    ) {
        self.localizedStringKey = localizedStringKey
        self.tableName = tableName
        self.bundle = bundle
        self.comment = comment
    }

    @inlinable
    public init(
        _ value: String,
        tableName: String? = nil,
        bundle: Bundle? = nil,
        comment: StaticString? = nil
    ) {
        self.init(
            LocalizedStringKey(value),
            tableName: tableName,
            bundle: bundle,
            comment: comment
        )
    }

    public var value: String {
        String(
            localized: .init(localizedStringKey.stringKey ?? ""),
            table: tableName,
            bundle: bundle
        )
    }
}

extension LocalizedStringKey {
    var stringKey: String? {
        Mirror(reflecting: self).children.first { $0.label == "key" }?.value as? String
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

extension BetterLocalizedStringKey: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(localizedStringKey.stringKey ?? String(describing: localizedStringKey))
        hasher.combine(tableName)
        hasher.combine(bundle)
        hasher.combine(comment?.description)
    }
}
