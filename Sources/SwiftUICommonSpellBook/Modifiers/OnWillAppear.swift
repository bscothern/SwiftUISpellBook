//
//  OnWillAppear.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 8/28/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

#if canImport(UIKit)
import UIKit

@usableFromInline
typealias OnWillAppearViewControllerRepresentable = UIViewControllerRepresentable
@usableFromInline
typealias OnWillAppearViewController = UIViewController

#elseif canImport(AppKit)
import AppKit

@usableFromInline
typealias OnWillAppearViewControllerRepresentable = NSViewControllerRepresentable
@usableFromInline
typealias OnWillAppearViewController = NSViewController
#endif

extension View {
    @inlinable
    public func onWillAppear(_ action: @escaping @MainActor () -> Void) -> some View {
        modifier(OnWillAppearViewModifier(action: action))
    }
}

@usableFromInline
struct OnWillAppearViewModifier: ViewModifier {
    @usableFromInline
    let action: @MainActor () -> Void

    @usableFromInline
    init(action: @escaping @MainActor () -> Void) {
        self.action = action
    }

    @usableFromInline
    func body(content: Content) -> some View {
        content
            .background(OnWillAppearView(action: action))
    }
}

@usableFromInline
struct OnWillAppearView: OnWillAppearViewControllerRepresentable {
    @usableFromInline
    final class ViewControllerType: OnWillAppearViewController {
        @usableFromInline
        let action: @MainActor () -> Void

        @usableFromInline
        init(action: @escaping @MainActor () -> Void) {
            self.action = action
            super.init(nibName: nil, bundle: nil)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        #if canImport(UIKit)
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            action()
        }
        #elseif canImport(AppKit)
        override func viewWillAppear() {
            super.viewWillAppear()
            action()
        }
        #endif
    }

    @usableFromInline
    let action: @MainActor () -> Void

    @usableFromInline
    init(action: @escaping @MainActor () -> Void) {
        self.action = action
    }

    @usableFromInline
    func makeNSViewController(context: Context) -> ViewControllerType {
        ViewControllerType(action: action)
    }

    @usableFromInline
    func updateNSViewController(_ nsViewController: ViewControllerType, context: Context) {
    }

    @usableFromInline
    func makeUIViewController(context: Context) -> ViewControllerType {
        ViewControllerType(action: action)
    }

    @usableFromInline
    func updateUIViewController(_ uiViewController: ViewControllerType, context: Context) {
    }
}
