//
//  PopNavigationLinkDestinationModifier.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/4/20.
//  Copyright © 2019-2021 Braden Scothern. All rights reserved.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#else
#error("Unsupported Platform")
#endif

public extension View {
    @inlinable
    func popNavigationLinkDestination() -> ModifiedContent<Self, _PopNavigationLinkDestinationModifier> {
        #if canImport(UIKit)
        _ = UINavigationController.PopViewControllerSwizzler.performSwizzle
        #elseif canImport(AppKit)
        fatalError("Not yet supported on macOS")
        #endif
        return modifier(_PopNavigationLinkDestinationModifier())
    }
}

public struct _PopNavigationLinkDestinationModifier: ViewModifier {
    @Environment(\EnvironmentValues.presentationMode)
    var presentationMode

    @State
    var popNavigation = _PopNavigation()

    @usableFromInline
    init() {}

    public func body(content: Content) -> some View {
        content
            .onAppear {
                guard PopNavigationState.shared.popCount > 0 else { return }
                PopNavigationState.shared.popCount -= 1
                self.presentationMode.wrappedValue.dismiss()
            }
            .popNavigation(pop: popNavigation)
            .environment(\.popNavigation, .init($popNavigation))
    }
}
