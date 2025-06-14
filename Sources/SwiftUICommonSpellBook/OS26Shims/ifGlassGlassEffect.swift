//
//  ifGlassEffect.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 6/14/25.
//

import SwiftUI

#if swift(>=6.2)
@available(iOS, obsoleted: 26, renamed: "glassEffect(_:in:isEnabled:)")
@available(macOS, obsoleted: 26, renamed: "glassEffect(_:in:isEnabled:)")
@available(tvOS, obsoleted: 26, renamed: "glassEffect(_:in:isEnabled:)")
@available(watchOS, obsoleted: 26, renamed: "glassEffect(_:in:isEnabled:)")
@available(visionOS, obsoleted: 26, renamed: "glassEffect(_:in:isEnabled:)")
extension View {
    @inlinable
    @ViewBuilder
    public func ifGlassGlassEffect(
        _ glass: Glass = .regular,
        in shape: some Shape = .capsule,
        isEnabled: Bool = true
    ) -> some View {
        if #available(iOS 26, macOS 26, tvOS 26, watchOS 26, visionOS 26, *),
           let glass = glass.value as? SwiftUI.Glass {
            self.glassEffect(glass, in: shape, isEnabled: isEnabled)
        } else {
            self
        }
    }
}
#else
extension View {
    @inlinable
    public func ifGlassGlassEffect(
        _ glass: Glass = .regular,
        in shape: some Shape = .capsule,
        isEnabled: Bool = true
    ) -> some View {
        self
    }
}
#endif

@available(iOS 18.0, *)
#Preview {
    ZStack {
        Color.black

        Button {
        } label: {
            Text("Hello, World!")
                .font(.title)
                .padding()
                .foregroundStyle(Color.white)
                .ifGlassGlassEffect(.regular.interactive())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
