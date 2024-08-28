//
//  OnSizeChange.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 3/24/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

@available(iOS 17, macOS 14, *)
public enum SizeChangeValue: Hashable, Sendable {
    case width(Double)
    case height(Double)
    case both(width: Double, height: Double)
}

@available(iOS 17, macOS 14, *)
public enum OnSizeChangeType {
    /// When the width or height changes.
    case either
    /// When the width changes.
    case width
    /// When the height changes.
    case height
}

extension View {
    @available(iOS 17, macOS 14, *)
    public func onSizeChange(of type: OnSizeChangeType = .either, _ action: @escaping (SizeChangeValue) -> Void) -> some View {
        modifier(
            OnSizeChangeAlertModifier(
                type: type,
                action: action
            )
        )
    }
}

@available(iOS 17, macOS 14, *)
struct OnSizeChangeAlertModifier: ViewModifier {
    let type: OnSizeChangeType
    let action: (SizeChangeValue) -> Void

    @State
    var firedInitial = false

    @State
    var isDisappearing = false

    init(type: OnSizeChangeType, action: @escaping (SizeChangeValue) -> Void) {
        self.type = type
        self.action = action
    }

    func body(content: Content) -> some View {
        content
            .onWillDisappear {
                isDisappearing = true
            }
            .background {
                GeometryReader { geometry in
                    Color.clear
                        .onChange(of: geometry.size, initial: true) { oldValue, newValue in
                            guard !isDisappearing else {
                                return
                            }
                            switch type {
                            case .either:
                                switch (oldValue.width == newValue.width, oldValue.height == newValue.height) {
                                case (true, true):
                                    guard !firedInitial else {
                                        break
                                    }
                                    firedInitial = true
                                    action(.both(width: newValue.width, height: newValue.height))
                                case (true, false):
                                    action(.height(newValue.height))
                                case (false, true):
                                    action(.width(newValue.width))
                                case (false, false):
                                    action(.both(width: newValue.width, height: newValue.height))
                                }
                            case .width:
                                if oldValue.width != newValue.width {
                                    action(.width(newValue.width))
                                }
                            case .height:
                                if oldValue.height != newValue.height {
                                    action(.width(newValue.height))
                                }
                            }
                        }
                }
            }
    }
}
