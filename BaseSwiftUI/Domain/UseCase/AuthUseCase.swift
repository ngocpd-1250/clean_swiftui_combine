//
//  AuthUseCase.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 19/04/2024.
//

import Foundation
import Factory

protocol AuthUseCaseType {
    func updateOnboardingStatus(isDone: Bool)
    func validateEmail(email: String) -> ValidationResult
    func validatePassword(password: String) -> ValidationResult
    func validateConfirmPassword(password: String, confirmPassword: String) -> ValidationResult
    func login(email: String, password: String) -> Observable<Void>
    func setIsLoggedIn(_ value: Bool)
    func register(email: String, password: String) -> Observable<Void>
}

struct AuthUseCase: AuthUseCaseType {
    @Injected(\.authRepository) private var authRepository

    func updateOnboardingStatus(isDone: Bool) {
        authRepository.updateOnboardingStatus(isDone: isDone)
    }

    func validateEmail(email: String) -> ValidationResult {
        authRepository.validateEmail(email: email)
    }

    func validatePassword(password: String) -> ValidationResult {
        authRepository.validatePassword(password: password)
    }

    func validateConfirmPassword(password: String, confirmPassword: String) -> ValidationResult {
        authRepository.validateConfirmPassword(password: password, confirmPassword: confirmPassword)
    }

    func login(email: String, password: String) -> Observable<Void> {
        authRepository.login(email: email, password: password)
    }

    func setIsLoggedIn(_ value: Bool) {
        authRepository.setIsLoggedIn(value)
    }

    func register(email: String, password: String) -> Observable<Void> {
        authRepository.register(email: email, password: password)
    }
}
