////
////  ifGlassDragConfiguration.swift
////  SwiftUISpellBook
////
////  Created by Braden Scothern on 6/19/25.
////
//
//import SwiftUI
//
//#if swift(>=6.2) || GlassCompatibliity
//extension View {
//    @available(tvOS, unavailable)
//    @available(watchOS, unavailable)
//    @ViewBuilder
//    public func ifGlassDragConfiguration(_ configuration: DragConfiguration) -> some View {
//        if #available(iOS 26, macOS 26, macCatalyst 26, visionOS 26, *) {
//            self.dragConfiguration(configuration.swiftUIValue)
//        } else {
//            self
//        }
//    }
//}
//#else
//extension View {
//    public func ifGlassDragConfiguration(_ configuration: DragConfiguration) -> some View {
//        self
//    }
//}
//#endif
