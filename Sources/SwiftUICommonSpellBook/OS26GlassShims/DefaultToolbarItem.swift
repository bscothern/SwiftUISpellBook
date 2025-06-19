//
//  DefaultToolbarItem.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

@available(iOS 16, macOS 16, macCatalyst 16, *)
public struct DefaultToolbarItem: ToolbarContent {
    @ToolbarContentBuilder
    public var body: some ToolbarContent {
        Never?.none
    }
}
