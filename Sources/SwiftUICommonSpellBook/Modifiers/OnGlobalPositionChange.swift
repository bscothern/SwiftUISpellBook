//
//  OnGlobalPositionChange.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 3/25/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    @available(iOS 17, macOS 14, *)
    public func onGlobalPositionChange(_ action: @escaping (_ globalFrame: CGRect) -> Void) -> some View {
        modifier(OnGlobalPositionChange(action: action))
    }
}

@available(iOS 17, macOS 14, *)
struct OnGlobalPositionChange: ViewModifier {
    let action: (_ globalFrame: CGRect) -> Void

    @State
    var isDisappearing = false

    init(action: @escaping (_ globalFrame: CGRect) -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content
            .onWillDisappear {
                isDisappearing = true
            }
            .background {
                GeometryReader { geometry in
                    let globalFrame = geometry.frame(in: GlobalCoordinateSpace())
                    VoidView()
                        .onChange(of: globalFrame, initial: true) { _, newValue in
                            guard !isDisappearing else {
                                return
                            }
                            action(newValue)
                        }
                }
            }
    }
}
