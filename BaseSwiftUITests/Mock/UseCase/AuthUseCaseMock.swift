//
//  AuthUseCaseMock.swift
//  BaseSwiftUITests
//
//  Created by phan.duong.ngoc on 24/04/2024.
//

@testable import BaseSwiftUI
import Foundation
import Combine

final class AuthUseCaseMock: AuthUseCaseType {
    var updateOnboardingStatusCalled = false
    var isDoneOnboarding = false

    func updateOnboardingStatus(isDone: Bool) {
        updateOnboardingStatusCalled = true
        isDoneOnboarding = isDone
    }

    func validateEmail(email: String) -> ValidationResult {
        Validator.validateEmail(email).mapToVoid()
    }

    func validatePassword(password: String) -> ValidationResult {
        Validator.validatePassword(password).mapToVoid()
    }

    func validateConfirmPassword(password: String, confirmPassword: String) -> ValidationResult {
        Validator.validateConfirmPassword(password, confirmPassword: confirmPassword).mapToVoid()
    }

    var loginCalled = false
    var loginReturnValue: Result<Void, Error> = .success(())

    func login(email _: String, password _: String) -> Observable<Void> {
        loginCalled = true
        return loginReturnValue.publisher.eraseToAnyPublisher()
    }

    var isLoggedIn = false

    func setIsLoggedIn(_ value: Bool) {
        isLoggedIn = value
    }

    var registerCalled = false
    var registerReturnValue: Result<Void, Error> = .success(())

    func register(email _: String, password _: String) -> Observable<Void> {
        registerCalled = true
        return registerReturnValue.publisher.eraseToAnyPublisher()
    }
}
