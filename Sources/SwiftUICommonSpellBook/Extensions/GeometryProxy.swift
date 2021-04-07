//
//  GeometryProxy.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/4/20.
//  Copyright © 2020-2021 Braden Scothern. All rights reserved.
//

import SwiftUI

extension GeometryProxy {
    @inlinable
    public var center: CGPoint { .init(x: size.width * 0.5, y: size.height * 0.5) }
}
