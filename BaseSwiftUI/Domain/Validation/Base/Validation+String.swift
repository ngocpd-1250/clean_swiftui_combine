//
//  Validation+String.swift
//
//  Created by phan.duong.ngoc on 2023/04/04.
//

import ValidatedPropertyKit

extension Validation where Value == String {
    public static func matches(_ pattern: String,
                               options: NSRegularExpression.Options = .init(),
                               matchingOptions: NSRegularExpression.MatchingOptions = .init(),
                               message: String) -> Validation {
        guard let regularExpression = try? NSRegularExpression(pattern: pattern, options: options) else {
            return .init { _ in .failure("Invalid regular expression: \(pattern)") }
        }

        return matches(
            regularExpression,
            matchingOptions: matchingOptions,
            message: message
        )
    }

    public static func matches(_ regex: NSRegularExpression,
                               matchingOptions: NSRegularExpression.MatchingOptions = .init(),
                               message: String) -> Validation {
        return .init { value in
            let firstMatchIsAvailable = regex.firstMatch(
                in: value,
                options: matchingOptions,
                range: .init(value.startIndex..., in: value)
            ) != nil

            if firstMatchIsAvailable {
                return .success(())
            } else {
                return .failure(ValidationError(message: message))
            }
        }
    }
}
