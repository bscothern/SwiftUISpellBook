//
//  OnWillDisappear.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 8/28/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI
import UIKit

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
struct OnWillDisappearView: UIViewControllerRepresentable {
    @usableFromInline
    final class UIViewControllerType: UIViewController {
        @usableFromInline
        let action: @MainActor () -> Void

        @usableFromInline
        init(action: @escaping @MainActor () -> Void) {
            self.action = action
            super.init()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            action()
        }
    }

    @usableFromInline
    let action: @MainActor () -> Void

    @usableFromInline
    init(action: @escaping @MainActor () -> Void) {
        self.action = action
    }

    @usableFromInline
    func makeUIViewController(context: Context) -> UIViewControllerType {
        UIViewControllerType(action: action)
    }

    @usableFromInline
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
