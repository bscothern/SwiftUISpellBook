//
//  NavigationBarTitle.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/18/21.
//  Copyright © 2020-2021 Braden Scothern. All rights reserved.
//

import SwiftUI

#if os(macOS)
extension View {
    @inlinable
    public func navigationBarTitle(_ title: String) -> some View {
        self
    }

    @inlinable
    public func navigationBarTitle(_ title: String, displayMode: NavigationBarItem.TitleDisplayMode) -> some View {
        self
    }

    @inlinable
    public func navigationBarTitle(_ title: Text) -> some View {
        self
    }

    @inlinable
    public func navigationBarTitle(_ title: Text, displayMode: NavigationBarItem.TitleDisplayMode) -> some View {
        self
    }
}

public enum NavigationBarItem {
    public enum TitleDisplayMode {
        case automatic
        case inline
        case large
    }
}
#endif
