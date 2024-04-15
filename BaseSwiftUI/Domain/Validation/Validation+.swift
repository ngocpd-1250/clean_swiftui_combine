//
//  Validation+.swift
//
//  Created by phan.duong.ngoc on 2023/04/04.
//

import Foundation
import ValidatedPropertyKit

extension Validation where Value == String {
    static func matchEmail(message: String) -> Validation {
        return .init { value in
            let regexEmail = "^(?![.\\-\\@])(?!.*((\\.\\.)|(\\.\\-)|(\\.\\@)|(\\-\\@)))[A-Za-z0-9'.\\/\\{\\}\\|\\`!#\\$%&*+\\-\\=?^_~]*+\\@[A-Za-z0-9]+([-.][A-Za-z0-9]{2,}+)*\\.[A-Za-z]{2,}+$"
            let validationStatus = NSPredicate(format: "SELF MATCHES %@", regexEmail)
            if validationStatus.evaluate(with: value) {
                return .success(())
            }
            return .failure(ValidationError(message: message))
        }
    }

    static func matchPassword(message: String) -> Validation {
        return .init { value in
            let regexPassword = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#\\$%^&*()_+{}\\[\\]:;<>,.?~=`/\\\\|\\\"'-])[A-Za-z\\d!@#\\$%^&*()_+{}\\[\\]:;<>,.?~=`/\\\\|\\\"'-]{8,255}$"
            let validationStatus = NSPredicate(format: "SELF MATCHES %@", regexPassword)
            if validationStatus.evaluate(with: value) {
                return .success(())
            }
            return .failure(ValidationError(message: message))
        }
    }
}

extension Result where Failure == ValidationError {
    var message: String {
        switch self {
        case .success:
            return ""
        case .failure(let error):
            return error.description.components(separatedBy: "\n").first ?? ""
        }
    }

    var isValid: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }

    func mapToVoid() -> ValidationResult {
        return map { _ in () }
    }
}
