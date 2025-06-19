//
//  ToolbarSpacer.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(iOS, obsoleted: 26)
@available(macOS, obsoleted: 26)
@available(macCatalyst, obsoleted: 26)
@available(iOS 16, macOS 16, macCatalyst 16, *)
public struct ToolbarSpacer: ToolbarContent, CustomizableToolbarContent {
    @ToolbarContentBuilder
    public var body: some CustomizableToolbarContent {
        Never?.none
    }

    public init(
        _ sizing: SpacerSizing = .flexible,
        placement: ToolbarItemPlacement = .automatic
    ) {
    }
}
