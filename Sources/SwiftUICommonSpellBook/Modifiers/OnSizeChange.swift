//
//  OnSizeChange.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 3/24/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

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
    public func onSizeChange(
        of type: OnSizeChangeType,
        uuid: UUID,
        perform action: @escaping (_ newSize: SizeChangeValue) -> Void
    ) -> some View {
        return modifier(
            SizeChangeAlertModifier<Self>(
                type: type,
                id: uuid.hashValue,
                action: action,
                lastWidth: nil,
                lastHeight: nil
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
    public func onSizeChange(
        of type: OnSizeChangeType,
        fileID: String = #fileID,
        function: String = #function,
        line: Int = #line,
        perform action: @escaping (_ newSize: SizeChangeValue) -> Void
    ) -> some View {
        return modifier(
            SizeChangeAlertModifier<Self>(
                type: type,
                id: "\(fileID)\(function)\(line)".hashValue,
                action: action,
                lastWidth: nil,
                lastHeight: nil
            )
        )
    }
}

/// Type of change to watch in ``View.onSizeChange()``/
public enum OnSizeChangeType {
    /// When the width or height changes.
    case either
    /// When the width changes.
    case width
    /// When the height changes.
    case height
}

@usableFromInline
struct SizeChangeAlertModifier<IDType>: ViewModifier {
    @usableFromInline
    let type: OnSizeChangeType

    @usableFromInline
    let id: Int

    @usableFromInline
    let action: (_ newSize: SizeChangeValue) -> Void

    @State
    var lastWidth: Double?

    @State
    var lastHeight: Double?

    @usableFromInline
    init(
        type: OnSizeChangeType,
        id: Int,
        action: @escaping (_ newSize: SizeChangeValue) -> Void,
        lastWidth: Double?,
        lastHeight: Double?
    ) {
        self.type = type
        self.id = id
        self.action = action
        self.lastWidth = lastWidth
        self.lastHeight = lastHeight
    }

    @usableFromInline
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geometry in
                    VoidView()
                        .preference(
                            key: ViewSizeChangedPreferenceKey<IDType>.self,
                            value: .init(value: .both(width: geometry.size.width, height: geometry.size.height), id: id)
                        )
                }
            }
            .onPreferenceChange(ViewSizeChangedPreferenceKey<IDType>.self) { value in
                guard id == value.id,
                      case let .both(width, height) = value.value else {
                    return
                }

                switch (type, width != lastWidth, height != lastHeight) {
                case (.either, true, true):
                    action(.both(width: width, height: height))
                case (.either, true, false),
                    (.width, true, _):
                    action(.width(width))
                case (.either, false, true),
                    (.height, _, true):
                    action(.height(height))
                default:
                    break
                }
            }
    }
}

struct ViewSizeChangedPreferenceKey<IDType>: PreferenceKey {
    @usableFromInline
    struct Value: Hashable {
        @usableFromInline
        var value: SizeChangeValue

        @usableFromInline
        var id: Int
    }

    static var defaultValue: Value {
        Value(
            value: .both(
                width: 0,
                height: 0
            ),
            id: 0
        )
    }

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

public enum SizeChangeValue: Hashable {
    case width(Double)
    case height(Double)
    case both(width: Double, height: Double)
}
