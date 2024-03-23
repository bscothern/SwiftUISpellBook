//
//  UserInterfaceSizeClass.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/30/21.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

#if !os(iOS)
import SwiftUI

/// A set of values that indicate the visual size available to the view.
///
/// - Important: This is a duplication of an iOS enum in order to allow code using it to compile on all platforms even when using it.
public enum UserInterfaceSizeClass {
    /// The compact size class.
    case compact
    /// The regular size class.
    case regular
}
#endif
