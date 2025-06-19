//
//  SearchToolbarBehavior.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

@available(iOS, obsoleted: 26)
@available(macOS, obsoleted: 26)
@available(macCatalyst, obsoleted: 26)
@available(tvOS, obsoleted: 26)
@available(watchOS, obsoleted: 26)
@available(visionOS, obsoleted: 26)
public struct SearchToolbarBehavior: Hashable, Sendable, SendableMetatype {
    enum Value {
        case automatic
        case minimize
    }
    
    let value: Value
    
    public static let automatic: Self = .init(value: .automatic)
    public static let minimize: Self = .init(value: .minimize)
}
