//
//  Drawer.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 2/8/25.
//

import SwiftUI

@available(iOS 15.0, *)
public struct Drawer<Content: View>: View {
    @Binding
    var isOpen: Bool
    let heights: Set<CGFloat>
    let content: () -> Content
    
    @State
    var currentHeight: CGFloat = 100
    
    let minHeight: CGFloat
    
    @GestureState
    var dragOffset: CGFloat = 0

    @Environment(\.drawerBackgroundColor)
    var backgroundColor
    
    @Environment(\.drawerHandleColor)
    var handleColor
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                background
                VStack {
                    handle
                    content()
                    Spacer()
                }
            }
            .offset(y: max(geometry.size.height - currentHeight + dragOffset, 0))
            .gesture(
                DragGesture()
                    .updating($dragOffset) { gesture, dragOffset, transaction in
                        dragOffset = gesture.translation.height
                    }
                    .onEnded { gesture in
                        let velocityThreshold: CGFloat = 2000
                        if gesture.velocity.height > velocityThreshold {
                            currentHeight = minHeight
                        } else if gesture.velocity.height < -velocityThreshold {
                            currentHeight = min(heights.max()!, geometry.size.height)
                        } else {
                            let currentLocation = geometry.size.height - currentHeight + gesture.translation.height
                            let height = heights.reduce(into: (.infinity as CGFloat, .infinity as CGFloat)) { result, value in
                                let distance = (geometry.size.height - value - currentLocation).magnitude
                                if distance < result.1 {
                                    result.0 = value
                                    result.1 = distance
                                }
                            }.0
                            currentHeight = min(height, geometry.size.height)
                        }
                    }
            )
            .animation(.default, value: currentHeight)
            .animation(.default, value: dragOffset)
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            currentHeight = minHeight
        }
        .onChange(of: currentHeight) { _ in
            isOpen = currentHeight != minHeight
        }
    }
    
    var background: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(backgroundColor)
    }
    
    var handle: some View {
        Capsule()
            .foregroundStyle(handleColor)
            .frame(width: 40, height: 10)
            .padding(.vertical)
    }

    public init(
        heights: Set<CGFloat>,
        isOpen: Binding<Bool> = .constant(false),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.heights = heights
        self._isOpen = isOpen
        self.content = content
        self.minHeight = heights.min()!
    }
}

// MARK: - Customization
@available(iOS 15.0, *)
enum DrawerBackgroundColor: EnvironmentKey {
    typealias Value = Color
    static let defaultValue: Color = Color(.systemGray6)
}

@available(iOS 15.0, *)
extension EnvironmentValues {
    var drawerBackgroundColor: Color {
        get { self[DrawerBackgroundColor.self] }
        set { self[DrawerBackgroundColor.self] = newValue }
    }
}

@available(iOS 15.0, *)
extension View {
    public func drawerBackgroundColor(_ newColor: Color) -> some View {
        self.environment(\.drawerBackgroundColor, newColor)
    }
}

@available(iOS 15.0, *)
enum DrawerHandleColor: EnvironmentKey {
    typealias Value = Color
    static let defaultValue: Color = .gray
}

@available(iOS 15.0, *)
extension EnvironmentValues {
    var drawerHandleColor: Color {
        get { self[DrawerHandleColor.self] }
        set { self[DrawerHandleColor.self] = newValue }
    }
}

@available(iOS 15.0, *)
extension View {
    public func drawerHandleColor(_ newColor: Color) -> some View {
        self.environment(\.drawerHandleColor, newColor)
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable
    @State
    var isOpen: Bool = false
    
    Drawer(
        heights: [100, 200, 500, UIScreen.main.bounds.height],
        isOpen: $isOpen
    ) {
        Text("Drawer is open: \(isOpen)")
            .foregroundStyle(Color.white)
    }
    .drawerHandleColor(.black)
    .drawerBackgroundColor(.blue)
}
