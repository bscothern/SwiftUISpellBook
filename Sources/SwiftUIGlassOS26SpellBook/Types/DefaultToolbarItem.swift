//
//  DefaultToolbarItem.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

#warning("TODO: Figure out how to make DefaultToolbarItem work as a shim")

@available(iOS, obsoleted: 26)
@available(macOS, obsoleted: 26)
@available(macCatalyst, obsoleted: 26)
@available(tvOS, obsoleted: 26)
@available(watchOS, obsoleted: 26)
@available(visionOS, obsoleted: 26)
@available(iOS 17, macOS 14, macCatalyst 17, tvOS 17, watchOS 10, visionOS 1, *)
public struct DefaultToolbarItem: ToolbarContent {
    @ToolbarContentBuilder
    public var body: some ToolbarContent {
        Never?.none
    }

    public init(kind: ToolbarDefaultItemKind, placement: ToolbarItemPlacement = .automatic) {
    }
}
