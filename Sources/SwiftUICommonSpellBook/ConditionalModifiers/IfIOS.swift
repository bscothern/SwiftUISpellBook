//
//  iOS.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 10/4/20.
//  Copyright © 2020-2021 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func ifIOS<ThenView>(@ViewBuilder _ thenView: (_ view: Self) -> ThenView) -> some View where ThenView: View {
        #if os(iOS)
        thenView(self)
        #else
        self
        #endif
    }
    
    @ViewBuilder
    public func ifIOS<ThenView, ElseView>(@ViewBuilder _ thenView: (_ view: Self) -> ThenView, @ViewBuilder else elseView: (_ view: Self) -> ElseView) -> some View where ThenView: View, ElseView: View {
        #if os(iOS)
        thenView(self)
        #else
        elseView(self)
        #endif
    }
}
