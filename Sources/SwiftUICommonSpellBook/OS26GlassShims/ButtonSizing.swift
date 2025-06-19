//
//  ButtonSizing.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

public struct ButtonSizing: Hashable, Sendable, SendableMetatype {
    enum Value {
        case automatic
        case fitted
        case flexible
    }
    
    public static let automatic = ButtonSizing(value: .automatic)
    public static let fitted = ButtonSizing(value: .fitted)
    public static let flexible = ButtonSizing(value: .flexible)
    
    let value: Value

#if swift(>=6.2) || GlassCompatibliity
    @available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *)
    var swiftUIValue: SwiftUI.ButtonSizing {
        switch value {
        case .automatic:
            .automatic
        case .fitted:
            .fitted
        case .flexible:
            .flexible
        }
    }
#endif
}
