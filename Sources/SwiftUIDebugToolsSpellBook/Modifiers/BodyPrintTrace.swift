//
//  PrintTrace.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/28/21.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    @inlinable
    public func bodyPrintTrace(file: StaticString = #file, line: Int = #line) -> Self {
        self.bodyPrint("\(file) -- \(line)")
    }
}
