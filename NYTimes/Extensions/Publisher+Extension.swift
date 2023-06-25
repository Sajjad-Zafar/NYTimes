//
//  Publisher+Extension.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import Combine

/// An extension on `Publisher` providing convenience methods to create publishers with specific behaviors.
extension Publisher {
    /// Creates an empty publisher that immediately finishes without emitting any values.
    /// - Returns: An empty publisher.
    static func empty() -> AnyPublisher<Output, Failure> {
        return Empty().eraseToAnyPublisher()
    }

    /// Creates a publisher that emits a single value and then finishes.
    /// - Parameter output: The value to emit.
    /// - Returns: A publisher that emits the provided value and then finishes.
    static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        return Just(output)
            .catch { _ in AnyPublisher<Output, Failure>.empty() }
            .eraseToAnyPublisher()
    }

    /// Creates a publisher that immediately fails with the given error.
    /// - Parameter error: The error to fail with.
    /// - Returns: A publisher that immediately fails with the provided error.
    static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        return Fail(error: error).eraseToAnyPublisher()
    }
}
