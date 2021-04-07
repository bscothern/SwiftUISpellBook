//
//  DragGesture.Value.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/4/20.
//  Copyright © 2020-2021 Braden Scothern. All rights reserved.
//

import SwiftUI

extension DragGesture.Value {
    @inlinable
    public func angleFromStartLocation() -> Angle {
        // FIXME: This can be cleaned up. It works my brain just wasn't working well when I wrote it...
        let angle: Double
        let value = Double(abs(atan(abs(translation.height) / abs(translation.width))))

        // The top left is (0,0) so negative is up/left and positive is down/right.
        switch (translation.height.sign, translation.width.sign) {
        case (.plus, .plus):
            angle = 2.0 * .pi - value
        case (.plus, .minus):
            angle = .pi + value
        case (.minus, .plus):
            angle = value
        case (.minus, .minus):
            angle = .pi - value
        }
        return .init(radians: angle)
    }
}
