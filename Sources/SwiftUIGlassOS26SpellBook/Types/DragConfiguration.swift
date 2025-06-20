////
////  DragConfiguration.swift
////  SwiftUISpellBook
////
////  Created by Braden Scothern on 6/19/25.
////
//
//import SwiftUI
//
//public struct DragConfiguration {
//    let allowMove: Bool
//    let allowDelete: Bool
//
//    let _operationsWithinApp: OperationsWithinApp?
//
//    @available(tvOS, unavailable)
//    @available(watchOS, unavailable)
//    var operationsWithinApp: OperationsWithinApp {
//        if let _operationsWithinApp {
//            _operationsWithinApp
//        } else if #available(iOS 26, macOS 26, macCatalyst 26, visionOS 26, *) {
//            #if os(macOS)
//            .init(allowMove: allowMove, allowDelete: allowDelete)
//            #else
//            .init(allowMove: allowMove)
//            #endif
//        } else {
//            fatalError()
//        }
//    }
//
//    let _operationsOutsideApp: OperationsOutsideApp?
//
//    @available(tvOS, unavailable)
//    @available(watchOS, unavailable)
//    init(allowMove: Bool) {
//        self.allowMove = allowMove
//        self.allowDelete = false
//        self._operationsWithinApp = nil
//        self._operationsOutsideApp = nil
//    }
//
//    @available(iOS, unavailable)
//    @available(macCatalyst, unavailable)
//    @available(tvOS, unavailable)
//    @available(watchOS, unavailable)
//    @available(visionOS, unavailable)
//    @available(macOS 12, *)
//    public init(allowMove: Bool, allowDelete: Bool) {
//        self.allowMove = allowMove
//        self.allowDelete = allowDelete
//        self._operationsWithinApp = nil
//        self._operationsOutsideApp = nil
//    }
//
//    @available(tvOS, unavailable)
//    @available(watchOS, unavailable)
//    @available(iOS 15, macOS 12, macCatalyst 15, visionOS 1, *)
//    public init(
//        operationsWithinApp: DragConfiguration.OperationsWithinApp = .init(),
//        operationsOutsideApp: DragConfiguration.OperationsOutsideApp = .init()
//    ) {
//        self.allowMove = false
//        self.allowDelete = false
//        self._operationsWithinApp = operationsWithinApp
//        self._operationsOutsideApp = operationsOutsideApp
//    }
//
//    #if swift(>=6.2) || GlassCompatibliity
//    @available(tvOS, unavailable)
//    @available(watchOS, unavailable)
//    @available(iOS 26, macOS 26, macCatalyst 26, visionOS 26, *)
//    var swiftUIValue: SwiftUI.DragConfiguration {
//        if let _operationsWithinApp,
//           let _operationsOutsideApp {
//            .init(
//                operationsWithinApp: _operationsWithinApp.swiftUIValue,
//                operationsOutsideApp: _operationsOutsideApp.swiftUIValue
//            )
//        } else {
//            #if os(macOS)
//            .init(allowMove: allowMove, allowDelete: allowDelete)
//            #else
//            .init(allowMove: allowMove)
//            #endif
//        }
//    }
//    #endif
//}
//
//#if swift(>=6.2) || GlassCompatibliity
//extension DragConfiguration {
//    public struct OperationsOutsideApp: Sendable {
//        let allowCopy: Bool
//        let allowMove: Bool
//        let allowDelete: Bool
//
//        @available(macOS, unavailable)
//        @available(tvOS, unavailable)
//        @available(watchOS, unavailable)
//        @available(iOS 15, macCatalyst 15, visionOS 1, *)
//        public init(allowCopy: Bool = true) {
//            self.allowCopy = allowCopy
//            self.allowMove = false
//            self.allowDelete = false
//        }
//
//        @available(iOS, unavailable)
//        @available(macCatalyst, unavailable)
//        @available(tvOS, unavailable)
//        @available(watchOS, unavailable)
//        @available(visionOS, unavailable)
//        @available(macOS 12, *)
//        public init(allowCopy: Bool = true, allowMove: Bool = false, allowDelete: Bool = false) {
//            self.allowCopy = allowCopy
//            self.allowMove = allowMove
//            self.allowDelete = allowDelete
//        }
//
//        @available(iOS, unavailable)
//        @available(macCatalyst, unavailable)
//        @available(tvOS, unavailable)
//        @available(watchOS, unavailable)
//        @available(visionOS, unavailable)
//        @available(macOS 12, *)
//        var allowAlias: Bool {
//            #if os(macOS)
//            if #available(macOS 26, *) {
//                return swiftUIValue.allowAlias
//            } else {
//                return false
//            }
//            #else
//            return false
//            #endif
//        }
//
//        @available(tvOS, unavailable)
//        @available(watchOS, unavailable)
//        @available(iOS 26, macOS 26, macCatalyst 26, visionOS 26, *)
//        var swiftUIValue: SwiftUI.DragConfiguration.OperationsOutsideApp {
//            #if os(macOS)
//            return .init(allowCopy: allowCopy, allowMove: allowMove, allowDelete: allowDelete)
//            #else
//            return .init(allowCopy: allowCopy)
//            #endif
//        }
//    }
//}
//#else
//extension DragConfiguration {
//    public struct OperationsOutsideApp: Sendable {
//        @available(macOS, unavailable)
//        @available(tvOS, unavailable)
//        @available(watchOS, unavailable)
//        @available(iOS 15, macCatalyst 15, visionOS 1, *)
//        public init(allowCopy: Bool = true) {
//        }
//
//        @available(iOS, unavailable)
//        @available(macCatalyst, unavailable)
//        @available(tvOS, unavailable)
//        @available(watchOS, unavailable)
//        @available(visionOS, unavailable)
//        @available(macOS 13, *)
//        @_disfavoredOverload
//        public init(allowCopy: Bool = true, allowMove: Bool = false, allowDelete: Bool = false) {
//        }
//
//        @available(iOS, unavailable)
//        @available(macCatalyst, unavailable)
//        @available(tvOS, unavailable)
//        @available(watchOS, unavailable)
//        @available(visionOS, unavailable)
//        @available(macOS 13, *)
//        var allowAlias: Bool {
//            false
//        }
//    }
//}
//#endif
//
//#if swift(>=6.2) || GlassCompatibliity
//extension DragConfiguration {
//    public struct OperationsWithinApp: Sendable {
//        let allowCopy: Bool
//        let allowMove: Bool
//        let allowDelete: Bool
//
//        @available(macOS, unavailable)
//        @available(tvOS, unavailable)
//        @available(watchOS, unavailable)
//        @available(iOS 15, macCatalyst 15, visionOS 1, *)
//        public init(allowMove: Bool = true) {
//            self.allowCopy = false
//            self.allowMove = allowMove
//            self.allowDelete = false
//        }
//
//        @available(iOS, unavailable)
//        @available(macCatalyst, unavailable)
//        @available(tvOS, unavailable)
//        @available(watchOS, unavailable)
//        @available(visionOS, unavailable)
//        @available(macOS 12, *)
//        public init(allowCopy: Bool = true, allowMove: Bool = false, allowDelete: Bool = false) {
//            self.allowCopy = allowCopy
//            self.allowMove = allowMove
//            self.allowDelete = allowDelete
//        }
//
//        @available(iOS, unavailable)
//        @available(macCatalyst, unavailable)
//        @available(tvOS, unavailable)
//        @available(watchOS, unavailable)
//        @available(visionOS, unavailable)
//        @available(macOS 12, *)
//        var allowAlias: Bool {
//            #if os(macOS)
//            if #available(macOS 26, *) {
//                return swiftUIValue.allowAlias
//            } else {
//                return false
//            }
//            #else
//            return false
//            #endif
//        }
//
//        @available(tvOS, unavailable)
//        @available(watchOS, unavailable)
//        @available(iOS 26, macOS 26, macCatalyst 26, visionOS 26, *)
//        var swiftUIValue: SwiftUI.DragConfiguration.OperationsWithinApp {
//            #if os(macOS)
//            return .init(allowCopy: allowCopy, allowMove: allowMove, allowDelete: allowDelete)
//            #else
//            return .init(allowMove: allowMove)
//            #endif
//        }
//    }
//}
//#else
//extension DragConfiguration {
//    public struct OperationsWithinApp: Sendable {
//        @available(macOS, unavailable)
//        @available(tvOS, unavailable)
//        @available(watchOS, unavailable)
//        @available(iOS 15, macCatalyst 15, visionOS 1, *)
//        public init(allowCopy: Bool = true) {
//        }
//
//        @available(iOS, unavailable)
//        @available(macCatalyst, unavailable)
//        @available(tvOS, unavailable)
//        @available(watchOS, unavailable)
//        @available(visionOS, unavailable)
//        @available(macOS 13, *)
//        @_disfavoredOverload
//        public init(allowCopy: Bool = true, allowMove: Bool = false, allowDelete: Bool = false) {
//        }
//
//        @available(iOS, unavailable)
//        @available(macCatalyst, unavailable)
//        @available(tvOS, unavailable)
//        @available(watchOS, unavailable)
//        @available(visionOS, unavailable)
//        @available(macOS 13, *)
//        var allowAlias: Bool {
//            false
//        }
//    }
//}
//#endif
