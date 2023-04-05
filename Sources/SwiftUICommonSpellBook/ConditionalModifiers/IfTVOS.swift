//
//  IfTVOS.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/28/21.
//  Copyright © 2020-2021 Braden Scothern. All rights reserved.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func ifTVOS<ThenView>(@ViewBuilder _ thenView: (_ view: Self) -> ThenView) -> some View where ThenView: View {
        #if os(tvOS)
        thenView(self)
        #else
        self
        #endif
    }

    @ViewBuilder
    public func ifTVOS<ThenView, ElseView>(@ViewBuilder _ thenView: (_ view: Self) -> ThenView, @ViewBuilder else elseView: (_ view: Self) -> ElseView) -> some View where ThenView: View, ElseView: View {
        #if os(tvOS)
        thenView(self)
        #else
        elseView(self)
        #endif
    }
}
