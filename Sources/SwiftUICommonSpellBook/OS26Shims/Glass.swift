//
//  Glass.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/14/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
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
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *) {
            Self(value: SwiftUI.Glass.regular)
        } else {
            Self(value: Old())
        }
    }

    @inlinable
    public func tint(_ color: Color?) -> Glass {
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *),
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
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *),
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
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *) {
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
@inlinable
public struct Glass: Equatable, Sendable {
    @usableFromInline
    struct Value: Equatable, Sendable {
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
    var value: Value
    
    @inlinable
    public static var regular: Glass {
        Self(value: Value())
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
