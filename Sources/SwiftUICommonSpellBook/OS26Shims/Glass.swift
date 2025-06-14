//
//  Glass.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/14/25.
//

import SwiftUI

#if swift(>=6.2)
public struct Glass: Equatable, Sendable {
    struct Old: Equatable, Sendable {
        var tint: Color?
        var interactive: Bool = false
    }

    var value: any Sendable

    public static var regular: Glass {
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *) {
            Self(value: SwiftUI.Glass.regular)
        } else {
            Self(value: Old())
        }
    }

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
public struct Glass: Equatable, Sendable {
    struct Value: Equatable, Sendable {
        var tint: Color? = nil
        var interactive: Bool = false
    }
    
    var value: Value
    
    public static var regular: Glass {
        Self(value: Value())
    }
    
    public func tint(_ color: Color?) -> Glass {
        var copy = self
        copy.value.tint = color
        return copy
    }
    
    public func interactive(_ isEnabled: Bool = true) -> Glass {
        var copy = self
        copy.value.interactive = isEnabled
        return copy
    }
    
    public static func == (a: Glass, b: Glass) -> Bool {
        a.value == b.value
    }
}
#endif
