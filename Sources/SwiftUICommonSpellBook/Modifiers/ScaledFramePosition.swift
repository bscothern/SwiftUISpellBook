//
//  ScaledFramePosition.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 9/5/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 16, *)
extension View {
    public func scaledFramePosition(_ scale: Double, position: ScaledFramePositionValue) -> some View {
        modifier(
            ScaledFramePosition(
                scale: scale,
                position: position
            )
        )
    }
}

@available(iOS 16, *)
public typealias ScaledFramePositionValue = RelativePositionValue

@available(iOS 16, *)
@usableFromInline
struct ScaledFramePosition: ViewModifier {
    @usableFromInline
    let scale: Double

    @usableFromInline
    let position: ScaledFramePositionValue

    @usableFromInline
    init(scale: Double, position: ScaledFramePositionValue) {
        self.scale = scale
        self.position = position
    }

    @usableFromInline
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            let scaledContent = content.frame(
                width: geometry.size.width * scale,
                height: geometry.size.height * scale
            )

            scaledContent
                .relativePosition(position)
        }
    }
}
