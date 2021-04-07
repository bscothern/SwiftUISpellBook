//
//  Binding.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 2/7/21.
//  Copyright © 2020-2021 Braden Scothern. All rights reserved.
//

import SwiftUI

extension Binding {
    public func debug(_ prefix: String = "", file: String = #file, line: UInt = #line) -> Binding<Value> {
        .init {
            print("\(prefix)\(!prefix.isEmpty ? " - " : "")\(file) - line \(line): get \(self.wrappedValue)")
            return self.wrappedValue
        } set: { newValue in
            print("\(prefix)\(!prefix.isEmpty ? " - " : "")\(file) - line \(line): set \(self.wrappedValue) to \(newValue)")
            self.wrappedValue = newValue
        }
    }
}
