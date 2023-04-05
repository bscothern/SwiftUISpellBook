//
//  OnReceive.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 1/28/21.
//  Copyright © 2020-2021 Braden Scothern. All rights reserved.
//

#if canImport(Combine)
import Combine
import SwiftUI

extension View {
    @inlinable
    @_disfavoredOverload
    public func onReceive<Publisher>(
        _ publisher: Publisher,
        perform action: @escaping (_ result: Result<Publisher.Output, Publisher.Failure>) -> Void
    ) -> some View where Publisher: Combine.Publisher {
        modifier(
            OnReceiveModifier(
                publisher: publisher,
                action: action
            )
        )
    }
}

@usableFromInline
struct OnReceiveModifier<Publisher>: ViewModifier where Publisher: Combine.Publisher {
    @usableFromInline
    let publisher: Publisher
    @usableFromInline
    let action: (Result<Publisher.Output, Publisher.Failure>) -> Void

    var resultPublisher: AnyPublisher<Result<Publisher.Output, Publisher.Failure>, Never> {
        publisher
            .map(Result.success)
            .catch { error in
                Just(Result.failure(error))
            }
            .eraseToAnyPublisher()
    }

    @usableFromInline
    init(
        publisher: Publisher,
        action: @escaping (Result<Publisher.Output, Publisher.Failure>) -> Void
    ) {
        self.publisher = publisher
        self.action = action
    }

    @usableFromInline
    func body(content: Content) -> some View {
        content
            .onReceive(resultPublisher, perform: action)
    }
}

#endif
