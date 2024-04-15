//
//  Validation+Collection.swift
//
//  Created by phan.duong.ngoc on 2023/04/04.
//

import ValidatedPropertyKit

extension Validation where Value: Collection {
    public static func nonEmpty(message: String) -> Validation {
        return .init { value in
            if !value.isEmpty {
                return .success(())
            } else {
                return .failure(ValidationError(message: message))
            }
        }
    }

    public static func minLength(min: Int, message: String) -> Validation {
        return .init { value in
            if value.count >= min {
                return .success(())
            } else {
                return .failure(ValidationError(message: message))
            }
        }
    }

    public static func maxLength(max: Int, message: String) -> Validation {
        return .init { value in
            if value.count <= max {
                return .success(())
            } else {
                return .failure(ValidationError(message: message))
            }
        }
    }
}
