//
//  OnPositionChange.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 3/25/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

@available(iOS 17, macOS 14, *)
extension View {
    /// Triggers an action when the height or width of a view changes sizes.
    ///
    /// - Note: This is always fired at least once when the view is first created and appears.
    ///
    /// - Parameters:
    ///   - type: The property type of the view to watch.
    ///   - uuid: To identify this instance.
    ///   - action: The action to perform when the view changes.
    /// - Returns: A view that will trigger `action` at the appropriate size changes of the view this is applied too.
    @inlinable
    public func onGlobalPositionChange(
        of type: OnGlobalPositionChangeType,
        uuid: UUID,
        perform action: @escaping (_ newPosition: OnPositionChangeValue) -> Void
    ) -> some View {
        return modifier(
            OnGlobalPositionChangeAlertModifier<Self>(
                type: type,
                id: uuid.hashValue,
                action: action,
                lastValue: nil
            )
        )
    }

    /// Triggers an action when the height or width of a view changes sizes.
    ///
    /// - Note: This is always fired at least once when the view is first created and appears.
    ///
    /// - Important: The `fileID`, `function` and `line` can be changed but need to be consistent across calls at each site in your applicaiton.
    ///     They also should create a unique combo between all of your other uses of this function in the app.
    ///     This is needed in order to differentiate which view changed so that updates are properly propigated properly.
    ///
    /// - Parameters:
    ///   - type: The property type of the view to watch.
    ///   - fileID: The `#fileID` of the function call, used for hashing.
    ///   - function: The `#function` of the function call, used for hashing.
    ///   - line: The `#line` of the function call, used for hashing.
    ///   - action: The action to perform when the view changes.
    /// - Returns: A view that will trigger `action` at the appropriate size changes of the view this is applied too.
    @inlinable
    public func onGlobalPositionChange(
        of type: OnGlobalPositionChangeType,
        fileID: String = #fileID,
        function: String = #function,
        line: Int = #line,
        perform action: @escaping (_ newPosition: OnPositionChangeValue) -> Void
    ) -> some View {
        return modifier(
            OnGlobalPositionChangeAlertModifier<Self>(
                type: type,
                id: "\(fileID)\(function)\(line)".hashValue,
                action: action,
                lastValue: nil
            )
        )
    }
}

@available(iOS 17, macOS 14, *)
public enum OnPositionChangeValue: Hashable {
    case float(CGFloat)
    case point(CGPoint)

    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.float(lhs), .float(rhs)):
            return lhs == rhs
        case let (.point(lhs), .point(rhs)):
            return lhs.x == rhs.x && lhs.y == rhs.y
        default:
            return false
        }
    }

    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .float(value):
            hasher.combine(1)
            hasher.combine(value)
        case let .point(value):
            hasher.combine(2)
            hasher.combine(value.x)
            hasher.combine(value.y)
        }
    }

    @usableFromInline
    static func value(in geometry: GeometryProxy, type: OnGlobalPositionChangeType) -> Self {
        let frame: CGRect = geometry.frame(in: GlobalCoordinateSpace())
        var isRightToLeft: Bool {
            guard let language = Locale.current.languageCode else {
                return false
            }
            let direction = Locale.characterDirection(forLanguage: language)
            return direction == .rightToLeft
        }

        switch type {
        case .center:
            return .point(CGPoint(x: frame.midX, y: frame.midY))
        case .top:
            return .float(frame.minY)
        case .bottom:
            return .float(frame.maxY)
        case .left:
            return .float(frame.minX)
        case .right:
            return .float(frame.maxX)
        case .leading:
            if isRightToLeft {
                return .float(frame.maxX)
            } else {
                return .float(frame.minX)
            }
        case .trailing:
            if isRightToLeft {
                return .float(frame.minX)
            } else {
                return .float(frame.maxX)
            }
        }
    }
}

/// Type of change to watch in ``View.onPositionChange()``/
@available(iOS 17, macOS 14, *)
public enum OnGlobalPositionChangeType {
    case center
    case top
    case bottom
    case left
    case right
    case leading
    case trailing
}

@available(iOS 17, macOS 14, *)
@usableFromInline
struct OnGlobalPositionChangeAlertModifier<IDType>: ViewModifier {
    @usableFromInline
    let type: OnGlobalPositionChangeType

    @usableFromInline
    let id: Int

    @usableFromInline
    let action: (_ newSize: OnPositionChangeValue) -> Void

    @State
    var lastValue: OnPositionChangeValue?

    @usableFromInline
    init(
        type: OnGlobalPositionChangeType,
        id: Int,
        action: @escaping (_ newPosition: OnPositionChangeValue) -> Void,
        lastValue: OnPositionChangeValue?
    ) {
        self.type = type
        self.id = id
        self.action = action
        self.lastValue = lastValue
    }

    @usableFromInline
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geometry in
                    let value = OnPositionChangeValue.value(
                        in: geometry,
                        type: type
                    )
                    VoidView()
                        .preference(
                            key: ViewPositionChangedPreferenceKey<IDType>.self,
                            value: .init(value: value, id: id)
                        )
                        .overlay {
                            {
                                let globalCoordinates = geometry.frame(in: GlobalCoordinateSpace())
                                let local = geometry.frame(in: .local)
                                return EmptyView()
                            }()
                        }
                }
            }
            .onPreferenceChange(ViewPositionChangedPreferenceKey<IDType>.self) { value in
                guard id == value.id,
                      lastValue != value.value else {
                    return
                }
                lastValue = value.value
                action(value.value)
            }
    }
}

@available(iOS 17, macOS 14, *)
struct ViewPositionChangedPreferenceKey<IDType>: PreferenceKey {
    @usableFromInline
    struct Value: Hashable {
        @usableFromInline
        var value: OnPositionChangeValue

        @usableFromInline
        var id: Int

        static func == (lhs: Self, rhs: Self) -> Bool {
            false
        }
    }

    static var defaultValue: Value { Value(value: .float(0), id: 0) }

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
