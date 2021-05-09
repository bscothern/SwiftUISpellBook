//
//  PopNavigationCount.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/3/20.
//  Copyright © 2019-2021 Braden Scothern. All rights reserved.
//

import SwiftUI

/// The machanism used to pop views on on the navigation stack.
///
/// Accessed through: `@Environment(\.popNavigation) var popNavigation`.
///
/// - Important: The view must have been pushed through a `PopNavigationLink` or a `NavigationLink` where the destination had the `PopNavigationLinkDestination()` modifier applied to it.
public struct PopNavigation {
    @usableFromInline
    var value: Binding<_PopNavigation>

    @usableFromInline
    init(_ value: Binding<_PopNavigation>) {
        self.value = value
    }

    @inlinable
    public func pop(count: Int) {
        value.wrappedValue.pop(count: count)
    }
}

/// The type that gets injected into the system to be the `@State` property that triggers a change so things pop.
@usableFromInline
struct _PopNavigation {
    @usableFromInline
    var value: Int = 0 {
        didSet { PopNavigationState.shared.popCount = value }
    }

    @usableFromInline
    init() {}

    @usableFromInline
    mutating func pop(count: Int) {
        self.value = count
    }
}

@usableFromInline
struct PopNavigationCountEnvironmentKey: EnvironmentKey {
    @usableFromInline
    static let defaultValue: Binding<_PopNavigation> = .constant(.init())
}

public extension EnvironmentValues {
    /// Gives access to the current `PopNavigation` that can start navigation pop events.
    var popNavigation: PopNavigation {
        get { PopNavigation(self[PopNavigationCountEnvironmentKey.self]) }
        set { self[PopNavigationCountEnvironmentKey.self] = newValue.value }
    }
}
