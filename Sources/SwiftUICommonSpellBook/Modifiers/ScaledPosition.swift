//
//  ScaledPosition.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 9/5/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 16, *)
extension View {
    public func scaledPosition(_ scale: Double, position: ScaledPositionValue) -> some View {
        modifier(
            ScaledPosition(
                scale: scale,
                position: position
            )
        )
    }
}

@available(iOS 16, *)
public enum ScaledPositionValue: CaseIterable, Identifiable {
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
struct ScaledPosition: ViewModifier {
    @usableFromInline
    enum ScaledPositionSimpleValue {
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
    let scale: Double

    @usableFromInline
    let position: ScaledPositionValue

    @usableFromInline
    init(scale: Double, position: ScaledPositionValue) {
        self.scale = scale
        self.position = position
    }

    @usableFromInline
    func body(content: Content) -> some View {
        let isLeftToRight = Locale.characterDirection(forLanguage: Locale.current.language.languageCode?.identifier ?? "") == .leftToRight

        var position: ScaledPositionSimpleValue
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

        return GeometryReader { geometry in
            let scaledContent = content.frame(
                width: geometry.size.width * scale,
                height: geometry.size.height * scale
            )

            switch position {
            case .center:
                scaledContent
                    .centered()
            case .left:
                HStack {
                    VStack {
                        Spacer()
                        scaledContent
                        Spacer()
                    }
                    Spacer()
                }
            case .right:
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        scaledContent
                        Spacer()
                    }
                }
            case .top:
                VStack {
                    HStack {
                        Spacer()
                        scaledContent
                        Spacer()
                    }
                    Spacer()
                }
            case .topLeft:
                VStack {
                    HStack {
                        scaledContent
                        Spacer()
                    }
                    Spacer()
                }
            case .topRight:
                VStack {
                    HStack {
                        Spacer()
                        scaledContent
                    }
                    Spacer()
                }
            case .bottom:
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        scaledContent
                        Spacer()
                    }
                }
            case .bottomLeft:
                VStack {
                    Spacer()
                    HStack {
                        scaledContent
                        Spacer()
                    }
                }
            case .bottomRight:
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        scaledContent
                    }
                }
            }
        }
    }
}
