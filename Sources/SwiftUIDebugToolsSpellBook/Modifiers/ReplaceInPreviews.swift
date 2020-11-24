//
//  ReplaceInPreviews.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/4/20.
//  Copyright © 2020 Braden Scothern. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    #if DEBUG
    @inlinable
    public func replaceInPreviews<ReplacementView>(shouldBeReplaced: Bool = true, with replacementView: ReplacementView) -> some View where ReplacementView: View {
        modifier(ReplaceInPreviewsModifier(shouldBeReplaced: shouldBeReplaced, with: replacementView))
    }
    #else
    @inlinable
    public func replaceInPreviews<ReplacementView>(shouldBeReplaced: Bool = true, with replacementView: ReplacementView) -> some View where ReplacementView: View {
        self
    }
    #endif
}

@usableFromInline
struct ReplaceInPreviewsModifier<ReplacementView: View>: ViewModifier {
    @usableFromInline
    let _shouldBeReplaced: Bool

    @usableFromInline
    var shouldBeReplaced: Bool { _shouldBeReplaced && isPreviewMode }

    @usableFromInline
    let replacementView: ReplacementView

    @usableFromInline
    var isPreviewMode: Bool { ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" }

    @usableFromInline
    init(shouldBeReplaced: Bool, with replacementView: ReplacementView) {
        self._shouldBeReplaced = shouldBeReplaced
        self.replacementView = replacementView
    }

    @usableFromInline
    func body(content: Content) -> some View {
        Group {
            if self.shouldBeReplaced {
                self.replacementView
            } else {
                content
            }
        }
    }
}
