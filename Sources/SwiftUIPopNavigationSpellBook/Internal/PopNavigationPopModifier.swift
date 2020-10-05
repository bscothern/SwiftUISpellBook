//
//  PopNavigationPopModifier.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/3/20.
//  Copyright © 2019-2020 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    @usableFromInline
    func popNavigation(pop count: _PopNavigation) -> some View {
        self.modifier(PopNavigationPopModifier(count: count.value))
    }
}

@usableFromInline
struct PopNavigationPopModifier: ViewModifier {
    @usableFromInline
    let count: Int

    @usableFromInline
    init(count: Int) {
        self.count = count
    }

    @usableFromInline
    func body(content: Content) -> some View {
        PopNavigationPopView(content: content, count: count)
    }
}

@usableFromInline
struct PopNavigationPopView<Content: View>: View {
    @usableFromInline
    @Environment(\EnvironmentValues.presentationMode)
    var presentationMode

    @usableFromInline
    let content: Content

    @usableFromInline
    let count: Int

    @usableFromInline
    var body: some View {
        content
            .preference(key: PopNavigationPreferenceKey.self, value: .init(popCount: count))
            .onPreferenceChange(PopNavigationPreferenceKey.self) { _ in
                guard PopNavigationState.shared.popCount > 0 else { return }
                PopNavigationState.shared.popCount -= 1
                self.presentationMode.wrappedValue.dismiss()
            }
    }

    @usableFromInline
    init(content: Content, count: Int) {
        self.content = content
        self.count = count
    }
}
