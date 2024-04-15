//
//  IfSizeClass.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/30/21.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI
import SwiftUIMissingComponentsSpellBook

#if !os(macOS)
extension View {
    @inlinable
    public func ifHorizontalSizeClass<
        ThenView
    >(
        is horizontalSizeClass: UserInterfaceSizeClass,
        @ViewBuilder then thenView: @escaping (IfSizeClass<ThenView, _PassThroughView>.Content) -> ThenView
    ) -> ModifiedContent<Self, IfSizeClass<ThenView, _PassThroughView>>
    where ThenView: View {
        // swiftlint:disable:next trailing_closure
        modifier(IfSizeClass(horizontalSizeClass: horizontalSizeClass, then: thenView, else: { _ in fatalViewError("Unreachable") }))
    }

    @inlinable
    public func ifHorizontalSizeClass<
        ThenView,
        ElseView
    >(
        is horizontalSizeClass: UserInterfaceSizeClass,
        @ViewBuilder then thenView: @escaping (IfSizeClass<ThenView, ElseView>.Content) -> ThenView,
        @ViewBuilder else elseView: @escaping (IfSizeClass<ThenView, ElseView>.Content) -> ElseView
    ) -> ModifiedContent<Self, IfSizeClass<ThenView, ElseView>>
    where
        ThenView: View,
        ElseView: View {
        modifier(IfSizeClass(horizontalSizeClass: horizontalSizeClass, then: thenView, else: elseView))
    }

    @inlinable
    public func ifVerticalSizeClass<
        ThenView
    >(
        is verticalSizeClass: UserInterfaceSizeClass,
        @ViewBuilder then thenView: @escaping (IfSizeClass<ThenView, _PassThroughView>.Content) -> ThenView
    ) -> ModifiedContent<Self, IfSizeClass<ThenView, _PassThroughView>>
    where ThenView: View {
        // swiftlint:disable:next trailing_closure
        modifier(IfSizeClass(verticalSizeClass: verticalSizeClass, then: thenView, else: { _ in fatalViewError("Unreachable")}))
    }

    @inlinable
    public func ifVerticalSizeClass<
        ThenView,
        ElseView
    >(
        is verticalSizeClass: UserInterfaceSizeClass,
        @ViewBuilder then thenView: @escaping (IfSizeClass<ThenView, ElseView>.Content) -> ThenView,
        @ViewBuilder else elseView: @escaping (IfSizeClass<ThenView, ElseView>.Content) -> ElseView
    ) -> ModifiedContent<Self, IfSizeClass<ThenView, ElseView>>
    where
        ThenView: View,
        ElseView: View {
        modifier(IfSizeClass(verticalSizeClass: verticalSizeClass, then: thenView, else: elseView))
    }
}

public struct IfSizeClass<ThenView, ElseView>: ViewModifier where ThenView: View, ElseView: View {
    #if os(iOS)
    @usableFromInline
    @Environment(\.horizontalSizeClass)
    var currentHorizontalSizeClass: UserInterfaceSizeClass?

    @usableFromInline
    @Environment(\.verticalSizeClass)
    var currentVerticalSizeClass: UserInterfaceSizeClass?

    @usableFromInline
    let horizontalSizeClass: UserInterfaceSizeClass?

    @usableFromInline
    let verticalSizeClass: UserInterfaceSizeClass?
    #endif

    @usableFromInline
    let thenView: (Content) -> ThenView

    @usableFromInline
    let elseView: (Content) -> ElseView

    @usableFromInline
    init(horizontalSizeClass: UserInterfaceSizeClass, then thenView: @escaping (Content) -> ThenView, else elseView: @escaping (Content) -> ElseView) {
        #if os(iOS)
        self.horizontalSizeClass = horizontalSizeClass
        self.verticalSizeClass = nil
        #endif
        self.thenView = thenView
        self.elseView = elseView
    }

    @usableFromInline
    init(verticalSizeClass: UserInterfaceSizeClass, then thenView: @escaping (Content) -> ThenView, else elseView: @escaping (Content) -> ElseView) {
        #if os(iOS)
        self.horizontalSizeClass = nil
        self.verticalSizeClass = verticalSizeClass
        #endif
        self.thenView = thenView
        self.elseView = elseView
    }

    @inlinable
    @ViewBuilder
    public func body(content: Content) -> some View {
        #if os(iOS)
        if let horizontalSizeClass = horizontalSizeClass {
            if currentHorizontalSizeClass == horizontalSizeClass {
                thenView(content)
            } else {
                elseView(content)
            }
        } else if let verticalSizeClass = verticalSizeClass {
            if currentVerticalSizeClass == verticalSizeClass {
                thenView(content)
            } else {
                elseView(content)
            }
        } else {
            fatalError("Unreachable")
        }
        #else
        if ElseView.self == _PassThroughView.self {
            content
        } else {
            elseView(content)
        }
        #endif
    }
}
#endif
