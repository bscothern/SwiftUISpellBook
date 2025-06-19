//
//  TextAlignmentStrategy.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

public struct TextAlignmentStrategy: Hashable, Sendable {
    enum Value: Sendable {
        case `default`
        case layoutBased
        case writingDirectionBased
    }

    let value: Value

    public static let `default` = TextAlignmentStrategy(value: .default)
    public static let layoutBased = TextAlignmentStrategy(value: .layoutBased)
    public static let writingDirectionBased = TextAlignmentStrategy(value: .writingDirectionBased)

    #if swift(>=6.2) || GlassCompatibliity
    @available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *)
    var swiftUIValue: Text.AlignmentStrategy {
        switch value {
        case .default:
            .default
        case .layoutBased:
            .layoutBased
        case .writingDirectionBased:
            .writingDirectionBased
        }
    }
    #endif
}
