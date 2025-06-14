//
//  RelativePosition.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 9/6/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 16, *)
extension View {
    public func relativePosition(_ position: RelativePositionValue) -> some View {
        modifier(
            RelativePosition(
                position: position
            )
        )
    }
}

@available(iOS 16, *)
public enum RelativePositionValue: CaseIterable, Identifiable {
    case center
    case left
    case right
    case top
    case topLeft
    case topRight
    case bottom
    case bottomLeft
    case bottomRight
    case leading
    case trailing
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing

    public var id: Self { self }

    public var isSimple: Bool {
        switch self {
        case .center,
             .left,
             .right,
             .top,
             .topLeft,
             .topRight,
             .bottom,
             .bottomLeft,
             .bottomRight:
            return true
        default:
            return false
        }
    }
}

@available(iOS 16, *)
@usableFromInline
struct RelativePosition: ViewModifier {
    @usableFromInline
    enum RelativePositionSimpleValue {
        case center
        case left
        case right
        case top
        case topLeft
        case topRight
        case bottom
        case bottomLeft
        case bottomRight
    }

    @usableFromInline
    let position: RelativePositionValue

    @usableFromInline
    init(position: RelativePositionValue) {
        self.position = position
    }

    @usableFromInline
    func body(content: Content) -> some View {
        let isLeftToRight = Locale.characterDirection(forLanguage: Locale.current.language.languageCode?.identifier ?? "") == .leftToRight

        var position: RelativePositionSimpleValue
        switch (self.position, isLeftToRight) {
        case (.leading, true):
            position = .left
        case (.leading, false):
            position = .right
        case (.trailing, true):
            position = .right
        case (.trailing, false):
            position = .left
        case (.bottomTrailing, true):
            position = .bottomRight
        case (.bottomTrailing, false):
            position = .bottomLeft
        case (.topLeading, true):
            position = .topLeft
        case (.topLeading, false):
            position = .topRight
        case (.topTrailing, true):
            position = .topRight
        case (.topTrailing, false):
            position = .topLeft
        case (.bottomLeading, true):
            position = .bottomLeft
        case (.bottomLeading, false):
            position = .bottomRight
        case (.center, _):
            position = .center
        case (.left, _):
            position = .left
        case (.right, _):
            position = .right
        case (.top, _):
            position = .top
        case (.topLeft, _):
            position = .topLeft
        case (.topRight, _):
            position = .topRight
        case (.bottom, _):
            position = .bottom
        case (.bottomLeft, _):
            position = .bottomLeft
        case (.bottomRight, _):
            position = .bottomRight
        }

        return GeometryReader { _ in
            switch position {
            case .center:
                content
                    .centered()
            case .left:
                HStack {
                    VStack {
                        Spacer()
                        content
                        Spacer()
                    }
                    Spacer()
                }
            case .right:
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        content
                        Spacer()
                    }
                }
            case .top:
                VStack {
                    HStack {
                        Spacer()
                        content
                        Spacer()
                    }
                    Spacer()
                }
            case .topLeft:
                VStack {
                    HStack {
                        content
                        Spacer()
                    }
                    Spacer()
                }
            case .topRight:
                VStack {
                    HStack {
                        Spacer()
                        content
                    }
                    Spacer()
                }
            case .bottom:
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        content
                        Spacer()
                    }
                }
            case .bottomLeft:
                VStack {
                    Spacer()
                    HStack {
                        content
                        Spacer()
                    }
                }
            case .bottomRight:
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        content
                    }
                }
            }
        }
    }
}
