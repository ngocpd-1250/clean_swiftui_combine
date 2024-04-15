//
//  LoginNavigatorMock.swift
//  BaseSwiftUITests
//
//  Created by phan.duong.ngoc on 24/04/2024.
//

@testable import BaseSwiftUI

final class LoginNavigatorMock: LoginNavigatorType {
    var toRegisterCalled = false

    func toRegister() {
        toRegisterCalled = true
    }

    var showErrorCalled = false
    var errorMessage: String?

    func showError(message: String) {
        showErrorCalled = true
        errorMessage = message
    }
}
