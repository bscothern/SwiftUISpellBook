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
@MainActor
@usableFromInline
@preconcurrency
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

    @ViewBuilder
    @usableFromInline
    func body(content: Content) -> some View {
        let isLeftToRight = Locale.characterDirection(forLanguage: Locale.current.language.languageCode?.identifier ?? "") == .leftToRight

        var position: RelativePositionSimpleValue {
            switch (self.position, isLeftToRight) {
            case (.leading, true):
                .left
            case (.leading, false):
                .right
            case (.trailing, true):
                .right
            case (.trailing, false):
                .left
            case (.bottomTrailing, true):
                .bottomRight
            case (.bottomTrailing, false):
                .bottomLeft
            case (.topLeading, true):
                .topLeft
            case (.topLeading, false):
                .topRight
            case (.topTrailing, true):
                .topRight
            case (.topTrailing, false):
                .topLeft
            case (.bottomLeading, true):
                .bottomLeft
            case (.bottomLeading, false):
                .bottomRight
            case (.center, _):
                .center
            case (.left, _):
                .left
            case (.right, _):
                .right
            case (.top, _):
                .top
            case (.topLeft, _):
                .topLeft
            case (.topRight, _):
                .topRight
            case (.bottom, _):
                .bottom
            case (.bottomLeft, _):
                .bottomLeft
            case (.bottomRight, _):
                .bottomRight
            }
        }

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
