//
//  SpacerSizing.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(iOS, obsoleted: 26)
@available(macOS, obsoleted: 26)
@available(macCatalyst, obsoleted: 26)
public struct SpacerSizing: Sendable {
    enum Value: Sendable {
        case fixed
        case flexible
    }

    let value: Value

    public static let fixed: SpacerSizing = .init(value: .fixed)
    public static let flexible: SpacerSizing = .init(value: .flexible)
    
    @available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *)
    var iOS26Value: SwiftUI.SpacerSizing {
        switch self.value {
        case .fixed:
            .fixed
        case .flexible:
            .flexible
        }
    }
}
