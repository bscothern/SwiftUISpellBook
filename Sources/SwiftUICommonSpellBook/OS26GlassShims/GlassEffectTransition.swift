//
//  GlassEffectTransition.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/14/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
@available(iOS, obsoleted: 26)
@available(macOS, obsoleted: 26)
@available(tvOS, obsoleted: 26)
@available(watchOS, obsoleted: 26)
@available(visionOS, obsoleted: 26)
public struct GlassEffectTransition: Sendable {
    @usableFromInline
    struct Old: Sendable {
        @usableFromInline
        init() {}
    }

    @usableFromInline
    var value: any Sendable
    
    @usableFromInline
    init(value: any Sendable) {
        self.value = value
    }

    @inlinable
    public static var identity: GlassEffectTransition {
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *) {
            .init(value: SwiftUI.GlassEffectTransition.identity)
        } else {
            .init(value: Old())
        }
    }

    @inlinable
    public static var matchedGeometry: GlassEffectTransition {
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *) {
            .init(value: SwiftUI.GlassEffectTransition.matchedGeometry)
        } else {
            .init(value: Old())
        }
    }

    @inlinable
    public static func matchedGeometry(
        properties: MatchedGeometryProperties = .frame,
        anchor: UnitPoint = .center
    ) -> GlassEffectTransition {
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *) {
            .init(value: SwiftUI.GlassEffectTransition.matchedGeometry(
                properties: properties,
                anchor: anchor)
            )
        } else {
            .init(value: Old())
        }
    }
}
#else
public struct GlassEffectTransition: Sendable {
    @inlinable
    public static var identity: GlassEffectTransition {
        .init()
    }
    
    @inlinable
    public static var matchedGeometry: GlassEffectTransition {
        .init()
    }
    
    @inlinable
    public static func matchedGeometry(
        properties: MatchedGeometryProperties = .frame,
        anchor: UnitPoint = .center
    ) -> GlassEffectTransition {
        .init()
    }

    @inlinable
    init() {}
}
#endif
