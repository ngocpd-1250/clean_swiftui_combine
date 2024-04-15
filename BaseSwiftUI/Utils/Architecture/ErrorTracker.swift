//
//  ErrorTracker.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 19/04/2024.
//

import Combine

public typealias ErrorTracker = PassthroughSubject<Error?, Never>

extension Publisher where Failure: Error {
    public func trackError(_ errorTracker: ErrorTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorTracker.send(error)
            }
        })
        .eraseToAnyPublisher()
    }
}
