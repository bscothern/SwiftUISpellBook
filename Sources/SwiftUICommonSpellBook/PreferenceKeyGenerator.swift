//
//  PreferenceKeyGenerator.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 7/12/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

@MainActor
var previousPreferenceKeys: [UUID: any PreferenceKey.Type] = [:]

@MainActor
var nextGeneratedPreferenceKey: [ObjectIdentifier: any ChainablePreferenceKey.Type] = [:]

@MainActor
public enum PreferenceKeyGenerator<BasePreferenceKey> where BasePreferenceKey: PreferenceKey {
    @MainActor
    enum PreferenceKeyChain<Chain>: @MainActor ChainablePreferenceKey {
        typealias Value = BasePreferenceKey.Value

        static var typeID: ObjectIdentifier {
            ObjectIdentifier(PreferenceKeyGenerator<BasePreferenceKey>.self)
        }

        static var defaultValue: Value {
            BasePreferenceKey.defaultValue
        }

        static func reduce(value: inout Value, nextValue: () -> Value) {
            BasePreferenceKey.reduce(value: &value, nextValue: nextValue)
        }

        static func nextLink() -> any ChainablePreferenceKey.Type {
            PreferenceKeyChain<Self>.self
        }

        static func createNext() -> any ChainablePreferenceKey.Type {
            let value = nextGeneratedPreferenceKey[typeID, default: PreferenceKeyChain<Void>.self]
            nextGeneratedPreferenceKey[typeID] = value.nextLink()
            return value
        }
    }

    public static func generate(id: UUID) -> any PreferenceKey.Type {
        guard let previous = previousPreferenceKeys[id] else {
            let value = PreferenceKeyChain<Void>.createNext()
            previousPreferenceKeys[id] = value
            return value
        }
        return previous
    }
}

typealias ChainablePreferenceKey = Chainable & PreferenceKey

@MainActor
protocol Chainable {
    static func nextLink() -> any ChainablePreferenceKey.Type
    static func createNext() -> any ChainablePreferenceKey.Type
}
