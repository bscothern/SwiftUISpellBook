//
//  SyncSize.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 4/22/24.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

@preconcurrency import Combine
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
    @MainActor
    public func syncSize<T>(type: SyncSizeType = .both, id: T.Type) -> some View {
        let objectID = ObjectIdentifier(id)
        let uuid = valuesToUUIDs[objectID, default: UUID()]
        valuesToUUIDs[objectID] = uuid
        return modifier(SyncSize(type: type, id: uuid))
    }

    @available(iOS 17, macOS 14, *)
    @MainActor
    public func syncSize<T>(type: SyncSizeType = .both, id: T) -> some View where T: Hashable {
        let uuid = valuesToUUIDs[id, default: UUID()]
        valuesToUUIDs[id] = uuid
        return modifier(SyncSize(type: type, id: uuid))
    }

    @available(iOS 17, macOS 14, *)
    @MainActor
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

@available(iOS 17, macOS 14, *)
final class SyncSizePublisher: Subject, Sendable {
    typealias Output = CGSize
    typealias Failure = Never

    @MainActor
    static var instances: [UUID: SyncSizePublisher] = [:]

    let id: UUID
    let base: PassthroughSubject<CGSize, Never> = .init()

    let lock = NSRecursiveLock()
    nonisolated(unsafe) var _isRunning = true
    var isRunning: Bool {
        get {
            lock.withLock { _isRunning }
        }
        set {
            lock.withLock { _isRunning = newValue }
        }
        _modify {
            lock.lock()
            defer {
                lock.unlock()
            }
            yield &_isRunning
        }
    }

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
