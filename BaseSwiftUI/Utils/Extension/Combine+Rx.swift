//
//  Combine+Rx.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 21/04/2024.
//

import Combine
import Foundation

public typealias Driver<T> = AnyPublisher<T, Never>
public typealias Observable<T> = AnyPublisher<T, Error>
public typealias PublishRelay<T> = PassthroughSubject<T, Never>
public typealias BehaviorRelay<T> = CurrentValueSubject<T, Never>

// MARK: - Driver
extension Publisher {
    public func asDriver() -> Driver<Output> {
        return self.catch { _ in Empty() }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    public static func just(_ output: Output) -> Driver<Output> {
        return Just(output).eraseToAnyPublisher()
    }

    public static func empty() -> Driver<Output> {
        return Empty().eraseToAnyPublisher()
    }
}

// MARK: - Observable
extension Publisher {
    public func asObservable() -> Observable<Output> {
        mapError { $0 }
            .eraseToAnyPublisher()
    }

    public static func just(_ output: Output) -> Observable<Output> {
        Just(output)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public static func empty() -> Observable<Output> {
        return Empty().eraseToAnyPublisher()
    }
}
