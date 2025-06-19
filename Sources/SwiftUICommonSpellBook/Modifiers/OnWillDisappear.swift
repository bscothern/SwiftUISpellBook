//
//  OnWillDisappear.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 8/28/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

import SwiftUI

#if canImport(UIKit)
import UIKit

@usableFromInline
typealias OnWillDisappearViewControllerRepresentable = UIViewControllerRepresentable
@usableFromInline
typealias OnWillDisappearViewController = UIViewController

#elseif canImport(AppKit)
import AppKit

@usableFromInline
typealias OnWillDisappearViewControllerRepresentable = NSViewControllerRepresentable
@usableFromInline
typealias OnWillDisappearViewController = NSViewController
#endif

extension View {
    @inlinable
    public func onWillDisappear(_ action: @escaping @MainActor () -> Void) -> some View {
        modifier(OnWillDisappearViewModifier(action: action))
    }
}

@usableFromInline
struct OnWillDisappearViewModifier: ViewModifier {
    @usableFromInline
    let action: @MainActor () -> Void

    @usableFromInline
    init(action: @escaping @MainActor () -> Void) {
        self.action = action
    }

    @usableFromInline
    func body(content: Content) -> some View {
        content
            .background(OnWillDisappearView(action: action))
    }
}

@usableFromInline
struct OnWillDisappearView: OnWillDisappearViewControllerRepresentable {
    @usableFromInline
    final class ViewControllerType: OnWillDisappearViewController {
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
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            action()
        }
        #elseif canImport(AppKit)
        override func viewWillDisappear() {
            super.viewWillDisappear()
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
