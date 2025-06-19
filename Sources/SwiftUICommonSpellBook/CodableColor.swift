//
//  CodableColor.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 8/22/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public struct CodableColor: Codable, Sendable, Hashable {
    #if canImport(UIKit)
    typealias NativeColor = UIColor
    #elseif canImport(AppKit)
    typealias NativeColor = NSColor
    #endif

    public enum Error: Swift.Error {
        /// Thrown when the native color cannot get the RGBA values of the provided Color
        case conversionFailure
    }

    enum CodingKeys: CodingKey {
        case r
        case g
        case b
        case a
    }

    /// The SwiftUI Color that is codable while contained in this type.
    public var value: Color

    public init(_ value: Color) {
        self.value = value
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let r = try container.decode(CGFloat.self, forKey: .r)
        let g = try container.decode(CGFloat.self, forKey: .g)
        let b = try container.decode(CGFloat.self, forKey: .b)
        let a = try container.decode(CGFloat.self, forKey: .a)
        let nativeColor = NativeColor(red: r, green: g, blue: b, alpha: a)
        self.init(Color(nativeColor))
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        #if os(macOS)
        NativeColor(value).getRed(&r, green: &g, blue: &b, alpha: &a)
        #else
        guard NativeColor(value).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            throw Error.conversionFailure
        }
        #endif
        try container.encode(r, forKey: .r)
        try container.encode(g, forKey: .g)
        try container.encode(b, forKey: .b)
        try container.encode(a, forKey: .a)
    }
}
