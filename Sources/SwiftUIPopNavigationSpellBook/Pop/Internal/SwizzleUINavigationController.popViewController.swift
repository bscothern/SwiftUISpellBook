//
//  SwizzleUINavigationController.popViewController.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 2/11/20.
//  Copyright © 2019-2020 Braden Scothern. All rights reserved.
//

import ObjectiveC
#if canImport(UIKit)
import UIKit

@objc
internal extension UINavigationController {
    @usableFromInline
    dynamic func swiftUISpellBookPopViewController(animated: Bool) {
        // This is not actually recursive since this gets swizzled it will actually call the original UINavigationController.popViewController(animated:)
        swiftUISpellBookPopViewController(animated: PopNavigationState.shared.popCount == 0)
    }

    @usableFromInline
    enum PopViewControllerSwizzler {
        @usableFromInline
        @inline(__always)
        static let performSwizzle: Void = {
            guard let originalMethod = class_getInstanceMethod(UINavigationController.self, #selector(UINavigationController.popViewController(animated:))),
                let newMethod = class_getInstanceMethod(UINavigationController.self, #selector(UINavigationController.swiftUISpellBookPopViewController(animated:))) else {
                    fatalError("Unable to find methods")
            }
            method_exchangeImplementations(originalMethod, newMethod)
        }()
    }
}
#endif
