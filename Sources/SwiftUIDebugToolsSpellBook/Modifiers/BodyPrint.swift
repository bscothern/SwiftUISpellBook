//
//  Print.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/28/21.
//  Copyright © 2020-2021 Braden Scothern. All rights reserved.
//

@_implementationOnly import SwiftUICommonSpellBook
import SwiftUI

extension View {
    public func bodyPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") -> Self {
        self.do {
            if let first = items.first {
                print(first, terminator: "")
                
                items.dropFirst().forEach {
                    Swift.print("\(separator)\($0)", terminator: "")
                }

                print(terminator, terminator: "")
            }
        }
    }
}
