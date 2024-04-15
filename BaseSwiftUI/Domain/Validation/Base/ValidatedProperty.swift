//
//  ValidatedProperty.swift
//
//  Created by phan.duong.ngoc on 2023/04/04.
//

import ValidatedPropertyKit

protocol ValidatedProperty {
    var isValid: Bool { get }
    var validationError: ValidationError? { get }
}

extension Validated: ValidatedProperty {}
