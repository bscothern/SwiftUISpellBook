//
//  CoinToggle.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 2/8/25.
//

import SwiftUI

public struct CoinToggle<Side1Content: View, Side2Content: View>: View {
    public enum Mode {
        case side1
        case side2

        mutating func toggle() {
            switch self {
            case .side1:
                self = .side2
            case .side2:
                self = .side1
            }
        }
    }

    @State
    var mode: Mode = .side1

    @State
    var rotation: CGFloat = 0

    @Binding
    var showingFront: Bool

    @State
    var animation: Animation?

    let side1: () -> Side1Content
    let side2: () -> Side2Content

    public var body: some View {
        Button {
            toggle()
        } label: {
            ZStack {
                side1()
                    .opacity(rotation == 0 ? 1 : 0)
                side2()
                    .opacity(rotation == 180 ? 1 : 0)
                    .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 0.0, y: 1.0, z: 0)
                    )
            }
            .drawingGroup()
            .rotation3DEffect(
                .degrees(rotation),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .animation(animation, value: rotation)
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            if !showingFront {
                toggle()
            }
        }
        .task {
            // Delays setting the animation in order to prevent it from animating on appear if it needs to show the back side of the coin
            animation = .easeInOut(duration: 0.6)
        }
    }

    func toggle() {
        mode.toggle()
        switch mode {
        case .side1:
            rotation = 0
            showingFront = true
        case .side2:
            rotation = 180
            showingFront = false
        }
    }

    public init(
        showingFront: Binding<Bool>,
        @ViewBuilder front side1: @escaping () -> Side1Content,
        @ViewBuilder back side2: @escaping () -> Side2Content
    ) {
        self._showingFront = showingFront
        self.side1 = side1
        self.side2 = side2
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable
    @State
    var showingFront: Bool = true

    CoinToggle(showingFront: $showingFront) {
        Color.green
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(lineWidth: 4)
                    .foregroundStyle(Color.black.opacity(0.5))
                    .padding(2)
                Text(Image(systemName: "dollarsign"))
                    .font(.system(size: 30))
            }
    } back: {
        Circle()
            .foregroundStyle(Color.yellow)
            .overlay {
                Circle()
                    .stroke(lineWidth: 4)
                    .foregroundStyle(Color.black.opacity(0.5))
                    .padding(2)
                Text(Image(systemName: "centsign"))
                    .font(.system(size: 30))
            }
    }
    .frame(width: 60)
    .onChange(of: showingFront) { _, showingFront in
        print("Showing Front: \(showingFront)")
    }
}
