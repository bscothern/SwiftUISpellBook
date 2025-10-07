//
//  Glass.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/14/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
@available(iOS, obsoleted: 26)
@available(macOS, obsoleted: 26)
@available(macCatalyst, obsoleted: 26)
@available(tvOS, obsoleted: 26)
@available(watchOS, obsoleted: 26)
@available(visionOS, obsoleted: 26)
public struct Glass: Equatable, Sendable {
    @usableFromInline
    struct Old: Equatable, Sendable {
        @usableFromInline
        var tint: Color?

        @usableFromInline
        var interactive: Bool

        @usableFromInline
        init(tint: Color? = nil, interactive: Bool = false) {
            self.tint = tint
            self.interactive = interactive
        }
    }

    @usableFromInline
    var value: any Sendable

    @usableFromInline
    init(value: any Sendable) {
        self.value = value
    }

    @inlinable
    public static var regular: Glass {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            Self(value: SwiftUI.Glass.regular)
        } else {
            Self(value: Old())
        }
    }
    
    @inlinable
    public static var identity: Glass {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            Self(value: SwiftUI.Glass.identity)
        } else {
            Self(value: Old())
        }
    }

    @inlinable
    public static var clear: Glass {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            Self(value: SwiftUI.Glass.clear)
        } else {
            Self(value: Old())
        }
    }

    @inlinable
    public func tint(_ color: Color?) -> Glass {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *),
           let glass = value as? SwiftUI.Glass {
            return Self(value: glass.tint(color))
        } else if var old = value as? Old {
            old.tint = color
            return Self(value: old)
        } else {
            assertionFailure("Unreachable")
            return Self(value: Old())
        }
    }

    @inlinable
    public func interactive(_ isEnabled: Bool = true) -> Glass {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *),
           let glass = value as? SwiftUI.Glass {
            return Self(value: glass.interactive(isEnabled))
        } else if var old = value as? Old {
            old.interactive = isEnabled
            return Self(value: old)
        } else {
            assertionFailure("Unreachable")
            return Self(value: Old())
        }
    }

    @inlinable
    public static func == (a: Glass, b: Glass) -> Bool {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
           if let aGlass = a.value as? SwiftUI.Glass,
              let bGlass = b.value as? SwiftUI.Glass {
               return aGlass == bGlass
           } else {
               return false
           }
        } else if let aOld = a.value as? Old,
                  let bOld = b.value as? Old {
            return aOld == bOld
        } else {
            return false
        }
    }
}
#else
public struct Glass: Equatable, Sendable {
    @usableFromInline
    enum Style: Equatable, Sendable {
        case regular
        case identity
        case clear
    }

    @usableFromInline
    struct Value: Equatable, Sendable {
        @usableFromInline
        var style: Style
        
        @usableFromInline
        var tint: Color?

        @usableFromInline
        var interactive: Bool

        @usableFromInline
        init(_ style: Style, tint: Color? = nil, interactive: Bool = false) {
            self.style = style
            self.tint = tint
            self.interactive = interactive
        }
    }

    @usableFromInline
    var value: Value

    @usableFromInline
    init(value: Value) {
        self.value = value
    }

    @inlinable
    public static var regular: Glass {
        Self(value: Value(.regular))
    }
    
    @inlinable
    public static var identity: Glass {
        Self(value: Value(.identity))
    }
    
    @inlinable
    public static var clear: Glass {
        Self(value: Value(.clear))
    }

    @inlinable
    public func tint(_ color: Color?) -> Glass {
        var copy = self
        copy.value.tint = color
        return copy
    }

    @inlinable
    public func interactive(_ isEnabled: Bool = true) -> Glass {
        var copy = self
        copy.value.interactive = isEnabled
        return copy
    }

    @inlinable
    public static func == (a: Glass, b: Glass) -> Bool {
        a.value == b.value
    }
}
#endif
