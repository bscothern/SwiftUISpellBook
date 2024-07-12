//
//  OnGlobalPositionChange.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 3/25/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    @available(iOS 17, macOS 14, *)
    public func onGlobalPositionChange(_ action: @escaping (_ globalFrame: CGRect) -> Void) -> some View {
        modifier(OnGlobalPositionChange(action: action))
    }
}

@available(iOS 17, macOS 14, *)
struct OnGlobalPositionChange: ViewModifier {
    let action: (_ globalFrame: CGRect) -> Void

    init(action: @escaping (_ globalFrame: CGRect) -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { geometry in
                    let globalFrame = geometry.frame(in: GlobalCoordinateSpace())
                    VoidView()
                        .onChange(of: globalFrame, initial: true) { _, newValue in
                            action(newValue)
                        }
                }
            }
    }
}

//
// @available(iOS 17, macOS 14, *)
// extension View {
//    /// Triggers an action when the height or width of a view changes sizes.
//    ///
//    /// - Note: This is always fired at least once when the view is first created and appears.
//    ///
//    /// - Parameters:
//    ///   - type: The property type of the view to watch.
//    ///   - uuid: To identify this instance.
//    ///   - action: The action to perform when the view changes.
//    /// - Returns: A view that will trigger `action` at the appropriate size changes of the view this is applied too.
//    @inlinable
//    public func onGlobalPositionChange(
//        of type: OnGlobalPositionChangeType,
//        uuid: UUID,
//        perform action: @escaping (_ newPosition: OnPositionChangeValue) -> Void
//    ) -> some View {
//        return modifier(
//            OnGlobalPositionChangeAlertModifier<Self>(
//                type: type,
//                uuid: uuid,
//                action: action,
//                lastValue: nil
//            )
//        )
//    }
//
//    /// Triggers an action when the height or width of a view changes sizes.
//    ///
//    /// - Note: This is always fired at least once when the view is first created and appears.
//    ///
//    /// - Important: The `fileID`, `function` and `line` can be changed but need to be consistent across calls at each site in your applicaiton.
//    ///     They also should create a unique combo between all of your other uses of this function in the app.
//    ///     This is needed in order to differentiate which view changed so that updates are properly propigated properly.
//    ///
//    /// - Parameters:
//    ///   - type: The property type of the view to watch.
//    ///   - fileID: The `#fileID` of the function call, used for hashing.
//    ///   - function: The `#function` of the function call, used for hashing.
//    ///   - line: The `#line` of the function call, used for hashing.
//    ///   - action: The action to perform when the view changes.
//    /// - Returns: A view that will trigger `action` at the appropriate size changes of the view this is applied too.
////    @inlinable
////    public func onGlobalPositionChange(
////        of type: OnGlobalPositionChangeType,
////        fileID: String = #fileID,
////        function: String = #function,
////        line: Int = #line,
////        perform action: @escaping (_ newPosition: OnPositionChangeValue) -> Void
////    ) -> some View {
////        return modifier(
////            OnGlobalPositionChangeAlertModifier<Self>(
////                type: type,
////                id: AnyHashable("\(fileID)\(function)\(line)"),
////                action: action,
////                lastValue: nil
////            )
////        )
////    }
// }
//
// @available(iOS 17, macOS 14, *)
// public enum OnPositionChangeValue: Hashable {
//    case float(CGFloat)
//    case point(CGPoint)
//
//    public static func == (lhs: Self, rhs: Self) -> Bool {
//        switch (lhs, rhs) {
//        case let (.float(lhs), .float(rhs)):
//            return lhs == rhs
//        case let (.point(lhs), .point(rhs)):
//            return lhs.x == rhs.x && lhs.y == rhs.y
//        default:
//            return false
//        }
//    }
//
//    public func hash(into hasher: inout Hasher) {
//        switch self {
//        case let .float(value):
//            hasher.combine(1)
//            hasher.combine(value)
//        case let .point(value):
//            hasher.combine(2)
//            hasher.combine(value.x)
//            hasher.combine(value.y)
//        }
//    }
//
//    @usableFromInline
//    static func value(in geometry: GeometryProxy, type: OnGlobalPositionChangeType) -> Self {
//        let frame: CGRect = geometry.frame(in: GlobalCoordinateSpace())
//        var isRightToLeft: Bool {
//            guard let language = Locale.current.languageCode else {
//                return false
//            }
//            let direction = Locale.characterDirection(forLanguage: language)
//            return direction == .rightToLeft
//        }
//
//        switch type {
//        case .center:
//            return .point(CGPoint(x: frame.midX, y: frame.midY))
//        case .top:
//            return .float(frame.minY)
//        case .bottom:
//            return .float(frame.maxY)
//        case .left:
//            return .float(frame.minX)
//        case .right:
//            return .float(frame.maxX)
//        case .leading:
//            if isRightToLeft {
//                return .float(frame.maxX)
//            } else {
//                return .float(frame.minX)
//            }
//        case .trailing:
//            if isRightToLeft {
//                return .float(frame.minX)
//            } else {
//                return .float(frame.maxX)
//            }
//        }
//    }
// }
//
///// Type of change to watch in ``View.onPositionChange()``/
// @available(iOS 17, macOS 14, *)
// public enum OnGlobalPositionChangeType {
//    case center
//    case top
//    case bottom
//    case left
//    case right
//    case leading
//    case trailing
// }
//
// @available(iOS 17, macOS 14, *)
// @usableFromInline
// struct OnGlobalPositionChangeAlertModifier<IDType>: ViewModifier {
//    @usableFromInline
//    let type: OnGlobalPositionChangeType
//    
//    @usableFromInline
//    let uuid: UUID
//    
//    @usableFromInline
//    let action: (_ newSize: OnPositionChangeValue) -> Void
//    
//    @State
//    var lastValue: OnPositionChangeValue?
//    
//    @usableFromInline
//    init(
//        type: OnGlobalPositionChangeType,
//        uuid: UUID,
//        action: @escaping (_ newPosition: OnPositionChangeValue) -> Void,
//        lastValue: OnPositionChangeValue?
//    ) {
//        self.type = type
//        self.uuid = uuid
//        self.action = action
//        self.lastValue = lastValue
//    }
//    
//    @usableFromInline
//    func body(content: Content) -> some View {
//        content
//            .overlay {
//                GeometryReader { geometry in
//                    let value = OnPositionChangeValue.value(
//                        in: geometry,
//                        type: type
//                    )
//                    VoidView()
//                        .preference(
//                            key: ViewPositionChangedPreferenceKey<IDType>.self,
//                            value: .init(value: value, uuid: uuid)
//                        )
//                }
//            }
//            .onPreferenceChange(ViewPositionChangedPreferenceKey<IDType>.self) { value in
//                let anyHashableValue = AnyHashable(value)
//                guard uuid == value.uuid,
//                      viewPositionChangeLastValue.updateValue(anyHashableValue, forKey: uuid) != anyHashableValue,
//                      lastValue != value.value else {
//                    return
//                }
//                lastValue = value.value
//                action(value.value)
//            }
//            .onDisappear {
//                viewPositionChangeLastValue.removeValue(forKey: uuid)
//            }
//    }
// }
//
// @MainActor
// private var viewPositionChangeLastValue: [AnyHashable: AnyHashable] = [:]
//
// @available(iOS 17, macOS 14, *)
// struct ViewPositionChangedPreferenceKey<IDType>: PreferenceKey {
//    @usableFromInline
//    struct Value: Hashable {
//        @usableFromInline
//        var value: OnPositionChangeValue
//
//        @usableFromInline
//        var uuid: UUID
//
////        static func == (lhs: Self, rhs: Self) -> Bool {
////            false
////        }
//    }
//
//    static var defaultValue: Value { Value(value: .float(0), uuid: .init()) }
//
//    static func reduce(value: inout Value, nextValue: () -> Value) {
//        value = nextValue()
//    }
// }
