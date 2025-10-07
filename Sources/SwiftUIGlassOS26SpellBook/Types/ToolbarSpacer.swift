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
    let sizing: SpacerSizing
    let placement: ToolbarItemPlacement
    
    @ToolbarContentBuilder
    public var body: some CustomizableToolbarContent {
        if #available(iOS 26, macOS 26, macCatalyst 26, tvOS 26, watchOS 26, visionOS 26, *) {
            SwiftUI.ToolbarSpacer(sizing.iOS26Value, placement: placement)
        }
    }

    public init(
        _ sizing: SpacerSizing = .flexible,
        placement: ToolbarItemPlacement = .automatic
    ) {
        self.sizing = sizing
        self.placement = placement
    }
}
