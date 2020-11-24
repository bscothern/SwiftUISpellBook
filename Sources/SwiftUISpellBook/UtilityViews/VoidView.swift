//
//  VoidView.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/4/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import SwiftUI

/// An `EmptyView` that will still cause things to render as if it had content.
///
/// This is useful for causing things such as preference keys to trigger when a normal `EmptyView` wouldn't.
public struct VoidView: View {
    @inlinable
    public var body: some View {
        // The ZStack is required to support preference keys.
        ZStack {
            Never?.none
        }
    }

    @inlinable
    public init() {}
}
