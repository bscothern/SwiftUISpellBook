//
//  OnWillAppear.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 8/28/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI
import UIKit

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
struct OnWillAppearView: UIViewControllerRepresentable {
    @usableFromInline
    final class UIViewControllerType: UIViewController {
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

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
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
