//
//  InSquare.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/3/25.
//

import SwiftUI

public struct InSquare<Content: View>: View {
    let content: (_ size: CGFloat) -> Content

    public init(
        @ViewBuilder content: @escaping (_ size: CGFloat) -> Content
    ) {
        self.content = content
    }

    public var body: some View {
        GeometryReader { geometry in
            let smallerSize = geometry.size.width < geometry.size.height ? geometry.size.width : geometry.size.height
            content(smallerSize)
                .frame(width: smallerSize, height: smallerSize)
        }
    }
}
