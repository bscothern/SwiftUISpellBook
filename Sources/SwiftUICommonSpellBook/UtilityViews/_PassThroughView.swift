//
//  _PassThroughView.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/30/21.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

/// Used to satisfy generic constraints, it allows you to mark things as pass through on modifiers when it can't be otherwise expressed.
///
/// This is an uninhabitable type just like `NeverView` but is seperated out so calls to `fatalViewError()` and uses of this type are different.
/// Without having the seperation you cannot check a generic type against `_PassThroughView` safely.
///
/// - Important:
///     You should not create any function or property that returns this type.
///     It should **only** be used to for generic constraints.
public enum _PassThroughView: View {
    public typealias Body = NeverView
    public var body: NeverView { fatalViewError("Unreachable") }
}
