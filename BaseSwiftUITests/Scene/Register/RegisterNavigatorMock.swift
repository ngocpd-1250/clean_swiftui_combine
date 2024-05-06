//
//  RegisterNavigatorMock.swift
//  BaseSwiftUITests
//
//  Created by phan.duong.ngoc on 06/05/2024.
//

@testable import BaseSwiftUI

final class RegisterNavigatorMock: RegisterNavigatorType {
    var toLoginCalled = false

    func toLogin() {
        toLoginCalled = true
    }

    var showErrorCalled = false
    var errorMessage: String?

    func showError(message: String) {
        errorMessage = message
        showErrorCalled = true
    }

    var showRegistrationSuccessCalled = false

    func showRegistrationSuccess() {
        showRegistrationSuccessCalled = true
    }
}
