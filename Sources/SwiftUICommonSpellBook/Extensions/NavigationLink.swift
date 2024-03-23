//
//  NavigationLink.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/30/21.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

extension NavigationLink {
    /// Creates an instance that presents destination when active with no label.
    ///
    /// - Parameters:
    ///   - destination: The desitnation to present when active.
    ///   - isActive: The binding that controls if the destination is shown.
    @inlinable
    public init(destination: Destination, isActive: Binding<Bool>) where Label == EmptyView {
        self.init(destination: destination, isActive: isActive, label: EmptyView.init)
    }

    /// Creates an instance that presents the destination when active with no label.
    ///
    /// - Parameters:
    ///   - destination: The desitnation to present when active.
    ///   - tag: The tag to tie to this destination.
    ///   - selection: A binding to the current tag selection.
    @inlinable
    public init<Tag>(destination: Destination, tag: Tag, selection: Binding<Tag?>) where Tag: Hashable, Label == EmptyView {
        self.init(destination: destination, tag: tag, selection: selection, label: EmptyView.init)
    }
}
