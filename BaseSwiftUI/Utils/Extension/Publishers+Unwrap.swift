//
//  Publishers+Unwrap.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 21/04/2024.
//

import Combine

public protocol OptionalType {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    public var value: Wrapped? {
        return self
    }
}

struct Unwrapped<Upstream>: Publisher where Upstream: Publisher, Upstream.Output: OptionalType {
    typealias Output = Upstream.Output.Wrapped
    typealias Failure = Upstream.Failure

    let upstream: Upstream

    func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        upstream
            .flatMap { optional -> AnyPublisher<Output, Failure> in
                guard let unwrapped = optional.value else {
                    return Empty<Output, Failure>().eraseToAnyPublisher()
                }
                return Just(unwrapped).setFailureType(to: Failure.self).eraseToAnyPublisher()
            }
            .receive(subscriber: subscriber)
    }
}

extension Publisher where Output: OptionalType {
    func unwrap() -> Unwrapped<Self> {
        return Unwrapped(upstream: self)
    }
}
