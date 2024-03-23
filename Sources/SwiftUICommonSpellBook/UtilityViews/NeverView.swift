//
//  NeverView.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/30/21.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import SwiftUI

/// A type that like `Never` can never be created but it conforms to the `View` protocol.
public enum NeverView: View {
    public typealias Body = Self

    @inline(never)
    public var body: Self {
        fatalError("Unreachable")
        return self
    }
}

public func fatalViewError(_ message: String, file: StaticString = #file, line: UInt = #line) -> NeverView {
    fatalError(message, file: file, line: line)
}
