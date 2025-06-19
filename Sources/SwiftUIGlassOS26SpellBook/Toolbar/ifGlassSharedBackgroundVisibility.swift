//
//  ifGlassSharedBackgroundVisibility.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/19/25.
//

import SwiftUI

#if swift(>=6.2) || GlassCompatibliity
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(iOS 16, tvOS 16, macCatalyst 16, *)
extension ToolbarContent {
    @available(iOS, obsoleted: 26, renamed: "sharedBackgroundVisibility(_:)")
    @available(macCatalyst, obsoleted: 26, renamed: "sharedBackgroundVisibility(_:)")
    @available(tvOS, obsoleted: 26, renamed: "sharedBackgroundVisibility(_:)")
    @ToolbarContentBuilder
    public func ifGlassSharedBackgroundVisibility(_ visibility: Visibility) -> some ToolbarContent {
        if #available(iOS 26, tvOS 26, macCatalyst 26, *) {
            self.sharedBackgroundVisibility(visibility)
        } else {
            self
        }
    }
}
#else
extension ToolbarContent {
    public func ifGlassSharedBackgroundVisibility(_ visibility: Visibility) -> some ToolbarContent {
        self
    }
}
#endif
