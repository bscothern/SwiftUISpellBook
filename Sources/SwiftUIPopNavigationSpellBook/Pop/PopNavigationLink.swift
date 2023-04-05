//
//  PopNavigationLink.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/3/20.
//  Copyright © 2019-2021 Braden Scothern. All rights reserved.
//

import SwiftUI

public struct PopNavigationLink<Label, Destination>: View where Label: View, Destination: View {
    @usableFromInline
    typealias PoppableDestination = ModifiedContent<Destination, _PopNavigationLinkDestinationModifier>

    @usableFromInline
    let navigationLink: NavigationLink<Label, PoppableDestination>

    @usableFromInline
    let isDetailLink: Bool

    @inlinable
    public var body: some View {
        #if os(iOS) || targetEnvironment(macCatalyst)
        return navigationLink
            .isDetailLink(isDetailLink)
        #else
        return navigationLink
        #endif
    }

    @inlinable
    internal init(_ navigationLink: NavigationLink<Label, PoppableDestination>, isDetailLink: Bool = true) {
        self.navigationLink = navigationLink
        self.isDetailLink = isDetailLink
    }
}

// MARK: - NavigationLink
// MARK: Init
public extension PopNavigationLink {
    @inlinable
    init(destination: Destination, isActive: Binding<Bool>, @ViewBuilder label: () -> Label) { // swiftlint:disable:this attributes
        self.init(.init(destination: destination.popNavigationLinkDestination(), isActive: isActive, label: label))
    }

    @inlinable
    init(destination: Destination, @ViewBuilder label: () -> Label) { // swiftlint:disable:this attributes
        self.init(.init(destination: destination.popNavigationLinkDestination(), label: label))
    }

    @inlinable
    init<V>(destination: Destination, tag: V, selection: Binding<V?>, @ViewBuilder label: () -> Label) where V: Hashable { // swiftlint:disable:this attributes
        self.init(.init(destination: destination.popNavigationLinkDestination(), tag: tag, selection: selection, label: label))
    }
}

public extension PopNavigationLink where Label == Text {
    @inlinable
    init(_ titleKey: LocalizedStringKey, destination: Destination) {
        self.init(.init(titleKey, destination: destination.popNavigationLinkDestination()))
    }

    @inlinable
    init<S>(_ title: S, destination: Destination) where S: StringProtocol {
        self.init(.init(title, destination: destination.popNavigationLinkDestination()))
    }

    @inlinable
    init(_ titleKey: LocalizedStringKey, destination: Destination, isActive: Binding<Bool>) {
        self.init(.init(titleKey, destination: destination.popNavigationLinkDestination(), isActive: isActive))
    }

    @inlinable
    init<S>(_ title: S, destination: Destination, isActive: Binding<Bool>) where S: StringProtocol {
        self.init(.init(title, destination: destination.popNavigationLinkDestination(), isActive: isActive))
    }

    @inlinable
    init<V>(_ titleKey: LocalizedStringKey, destination: Destination, tag: V, selection: Binding<V?>) where V: Hashable {
        self.init(.init(titleKey, destination: destination.popNavigationLinkDestination(), tag: tag, selection: selection))
    }

    @inlinable
    init<S, V>(_ title: S, destination: Destination, tag: V, selection: Binding<V?>) where S: StringProtocol, V: Hashable {
        self.init(.init(title, destination: destination.popNavigationLinkDestination(), tag: tag, selection: selection))
    }
}

// MARK: Instance Methods

@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public extension PopNavigationLink {
    /// Sets whether or not the `NavigationLink` should present its destination
    /// as the "detail" component of the containing `NavigationView`.
    ///
    /// If not set, defaults to `true`.
    func isDetailLink(_ isDetailLink: Bool) -> some View {
        Self(self.navigationLink, isDetailLink: isDetailLink)
    }
}
