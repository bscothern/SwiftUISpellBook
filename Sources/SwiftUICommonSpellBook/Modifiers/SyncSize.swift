//
//  SyncSize.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 4/22/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

@available(iOS 17, macOS 14, *)
public enum SyncSizeType {
    case both
    case width
    case height
}

@MainActor
var valuesToUUIDs: [AnyHashable: UUID] = [:]

extension View {
    @available(iOS 17, macOS 14, *)
    public func syncSize<T>(type: SyncSizeType = .both, id: T.Type) -> some View {
        MainActor.assumeIsolated {
            let objectID = ObjectIdentifier(id)
            let uuid = valuesToUUIDs[objectID, default: UUID()]
            valuesToUUIDs[objectID] = uuid
            return modifier(SyncSize(type: type, id: uuid))
        }
    }

    @available(iOS 17, macOS 14, *)
    public func syncSize<T>(type: SyncSizeType = .both, id: T) -> some View where T: Hashable {
        MainActor.assumeIsolated {
            let uuid = valuesToUUIDs[id, default: UUID()]
            valuesToUUIDs[id] = uuid
            return modifier(SyncSize(type: type, id: uuid))
        }
    }

    @available(iOS 17, macOS 14, *)
    public func syncSize(type: SyncSizeType = .both, id: UUID) -> some View {
        modifier(SyncSize(type: type, id: id))
    }
}

@available(iOS 17, macOS 14, *)
struct SyncSize: ViewModifier {
    let type: SyncSizeType
    let id: UUID

    @State
    var size: CGSize?

    init(type: SyncSizeType, id: UUID) {
        self.type = type
        self.id = id
    }

    func body(content: Content) -> some View {
        MainActor.assumeIsolated {
            let publisher = SyncSizePublisher.for(id: id)
            return content
                .frame(width: size?.width, height: size?.height)
                .onReceive(publisher) { value in
                    guard let size = size else {
                        self.size = value
                        return
                    }
                    if size.width < value.width {
                        self.size?.width = value.width
                    }
                    if size.height < value.height {
                        self.size?.height = value.height
                    }
                }
                .background {
                    GeometryReader { geometry in
                        VoidView()
                            .onChange(of: geometry.size, initial: true) {
                                guard !(geometry.size == .zero && self.size == nil) else {
                                    return
                                }
                                publisher.send(geometry.size)
                            }
                    }
                }
        }
    }
}

@available(iOS 17, macOS 14, *)
final class SyncSizePublisher: Subject {
    typealias Output = CGSize
    typealias Failure = Never

    @MainActor
    static var instances: [UUID: SyncSizePublisher] = [:]

    let id: UUID
    let base: PassthroughSubject<CGSize, Never> = .init()
    var isRunning = true

    @MainActor
    static func `for`(id: UUID) -> SyncSizePublisher {
        if let instance = instances[id],
           instance.isRunning {
            return instance
        } else {
            return .init(id: id)
        }
    }

    @MainActor
    private init(id: UUID) {
        self.id = id
        Self.instances[id] = self
    }

    func send(subscription: any Subscription) {
        base.send(subscription: subscription)
    }

    func send(_ value: CGSize) {
        base.send(value)
    }

    func send(completion: Subscribers.Completion<Never>) {
        base.send(completion: completion)
        isRunning = false
        Task { @MainActor in
            guard Self.instances[id] === self else {
                return
            }
            Self.instances.removeValue(forKey: id)
        }
    }

    func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, CGSize == S.Input {
        base.receive(subscriber: subscriber)
    }
}

// import Combine
// import SwiftUI
//
// public enum SyncSizeType {
//    case both
//    case width
//    case height
// }
//
// extension View {
//    public func syncSize<ID>(
//        type syncSizeType: SyncSizeType,
//        id: ID.Type
//    ) -> some View {
//        return modifier(
//            SyncSizeModifier(
//                syncSizeType: syncSizeType,
//                id: ObjectIdentifier(id)
//            )
//        )
//    }
//
//    public func syncSize(
//        type syncSizeType: SyncSizeType,
//        id: AnyHashable
//    ) -> some View {
//        modifier(
//            SyncSizeModifier(
//                syncSizeType: syncSizeType,
//                id: id
//            )
//        )
//    }
//
//    // TODO: Make this automatic
//    public func _disposeSyncSizeOnDisappear<ID>(
//        id: ID.Type
//    ) -> some View {
//        return self.onDisappear {
//            SyncSizePublishers.publishers.removeValue(forKey: ObjectIdentifier(id))
//        }
//    }
//
//    public func _disposeSyncSizeOnDisappear(
//        id: AnyHashable
//    ) -> some View {
//        return self.onDisappear {
//            SyncSizePublishers.publishers.removeValue(forKey: id)
//        }
//    }
// }
//
// enum SyncSizePublishers {
//    final class _ValuePublisher: Publisher {
//        typealias Output = SizeChangeValue
//        typealias Failure = Never
//
//        final class _Sub<S>: Subscriber, Subscription
//        where S: Subscriber,
//              S.Failure == Failure,
//              S.Input == Output {
//            typealias Input = _ValuePublisher.Output
//            typealias Failure = _ValuePublisher.Failure
//
//            var outSub: S?
//            var inSubs: [CombineIdentifier: any Subscription] = [:]
//
//            init(_ outSub: S) {
//                self.outSub = outSub
//            }
//
//            func receive(subscription: any Subscription) {
//                inSubs[subscription.combineIdentifier] = subscription
//            }
//
//            func receive(_ input: Input) -> Subscribers.Demand {
//                outSub?.receive(input) ?? .unlimited
//            }
//
//            func receive(completion: Subscribers.Completion<Failure>) {
//                outSub?.receive(completion: completion)
//            }
//
//            func request(_ demand: Subscribers.Demand) {
//                inSubs.values.forEach { $0.request(demand) }
//            }
//
//            func cancel() {
//                inSubs.values.forEach { $0.cancel() }
//            }
//        }
//
//        let passThrough: PassthroughSubject<Output, Failure> = .init()
//
//        func receive<S>(
//            subscriber: S
//        ) where S: Subscriber,
//                S.Failure == Failure,
//                S.Input == Output {
//            subscriber.receive(
//                subscription: _Sub(subscriber)
//            )
//            // passThrough.receive(subscriber: <#T##Subscriber#>)
//        }
//
//        func send(_ value: Output) {
//        }
//    }
//
//    typealias ValuePublisher =
////    _ValuePublisher
//    PassthroughSubject<SizeChangeValue, Never>
//
//    fileprivate static var publishers: [AnyHashable: ValuePublisher] = [:]
//
//    static func publisher(for id: AnyHashable) -> ValuePublisher {
//        guard let publisher = publishers[id] else {
//            let publisher = ValuePublisher()
//            publishers[id] = publisher
//            return publisher
//        }
//        return publisher
//    }
// }
//
// struct SyncSizeModifier: ViewModifier {
//    let syncSizeType: SyncSizeType
//    let id: AnyHashable
//
//    @State
//    var size: SizeChangeValue
//
//    init(syncSizeType: SyncSizeType, id: AnyHashable) {
//        self.syncSizeType = syncSizeType
//        self.id = id
//
//        switch syncSizeType {
//        case .both:
//            size = .both(width: .zero, height: .zero)
//        case .width:
//            size = .width(.zero)
//        case .height:
//            size = .height(.zero)
//        }
//    }
//
//    func body(content: Content) -> some View {
//        content
//            .frame(width: size.frameWidth, height: size.frameheight)
//            .onReceive(SyncSizePublishers.publisher(for: id)) { size in
//                switch (self.syncSizeType, size) {
//                case let (.both, .both(width, height)):
//                    guard case let .both(currentWidth, currentHeight) = self.size else {
//                        break
//                    }
//                    self.size = .both(
//                        width: max(currentWidth, width),
//                        height: max(currentHeight, height)
//                    )
//                case let (.width, .width(width)):
//                    guard case let .width(currentWidth) = self.size else {
//                        break
//                    }
//                    self.size = .width(max(currentWidth, width))
//                case let (.height, .height(height)):
//                    guard case let .height(currentHeight) = self.size else {
//                        break
//                    }
//                    self.size = .height(max(currentHeight, height))
//                default:
//                    break
//                }
//            }
//            .onSizeChange(of: OnSizeChangeType(matching: syncSizeType)) { size in
//                guard self.size != size else {
//                    return
//                }
//                SyncSizePublishers.publisher(for: id)
//                    .send(size)
//            }
//    }
// }
//
// private extension SizeChangeValue {
//    var frameWidth: CGFloat? {
//        switch self {
//        case let .width(width),
//            let .both(width, _):
//            guard !width.isZero, !width.isNaN else {
//                return nil
//            }
//            return width
//        default:
//            return nil
//        }
//    }
//
//    var frameheight: CGFloat? {
//        switch self {
//        case let .height(height),
//            let .both(_, height):
//            guard !height.isZero, !height.isNaN else {
//                return nil
//            }
//            return height
//        default:
//            return nil
//        }
//    }
// }
//
// extension OnSizeChangeType {
//    init(matching syncSizeType: SyncSizeType) {
//        switch syncSizeType {
//        case .both:
//            self = .either
//        case .width:
//            self = .width
//        case .height:
//            self = .height
//        }
//    }
// }
