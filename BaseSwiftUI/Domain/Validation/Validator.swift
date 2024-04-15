//
//  Validator.swift
//
//  Created by phan.duong.ngoc on 2023/04/04.
//

import ValidatedPropertyKit

struct Validator {
    @Validated(.minLength(min: 1, message: R.string.localizable.validationEmailEmpty())
        && .maxLength(max: 128, message: R.string.localizable.validationEmailMaxlength())
        && .matchEmail(message: R.string.localizable.validationEmailInvalid()))

    var email: String?

    @Validated(.minLength(min: 1, message: R.string.localizable.validationPasswordEmpty())
        && .maxLength(max: 255, message: R.string.localizable.validationPasswordMaxlength())
        && .matchPassword(message: R.string.localizable.validationPasswordInvalid()))

    var password: String?

    var validatedProperties: [ValidatedProperty] {
        return [
            _email,
            _password
        ]
    }
}

extension Validator {
    static func validateEmail(_ email: String) -> Result<String, ValidationError> {
        return Validator()._email.isValid(value: email)
    }

    static func validatePassword(_ password: String) -> Result<String, ValidationError> {
        return Validator()._password.isValid(value: password)
    }

    static func validateConfirmPassword(_ password: String,
                                        confirmPassword: String) -> Result<String, ValidationError> {
        if confirmPassword.isEmpty {
            return .failure(ValidationError(message: R.string.localizable.validationConfirmPasswordEmpty()))
        }
        return password == confirmPassword ?
            .success("") : .failure(ValidationError(message: R.string.localizable.validationConfirmPasswordInvalid()))
    }
}
