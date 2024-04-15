//
//  Validation+Comparable.swift
//
//  Created by phan.duong.ngoc on 2023/04/04.
//

import ValidatedPropertyKit

extension Validation where Value: Comparable {
    public static func greaterOrEqual(_ comparableValue: Value, message: String) -> Validation {
        return .init { value in
            if value >= comparableValue {
                return .success(())
            } else {
                return .failure(ValidationError(message: message))
            }
        }
    }

    public static func greater(_ comparableValue: Value, message: String) -> Validation {
        return .init { value in
            if value > comparableValue {
                return .success(())
            } else {
                return .failure(ValidationError(message: message))
            }
        }
    }
}
