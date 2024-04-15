//
//  AuthRepositoryImpl.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 19/04/2024.
//

import Foundation
import Combine
import Factory
import Defaults

struct AuthRepositoryImpl: AuthRepository {
    @Injected(\.auth) private var auth

    func updateOnboardingStatus(isDone: Bool) {
        Defaults[.isOnboardingCompleted] = isDone
    }

    func validateEmail(email: String) -> ValidationResult {
        return Validator.validateEmail(email).mapToVoid()
    }

    func validatePassword(password: String) -> ValidationResult {
        return Validator.validatePassword(password).mapToVoid()
    }

    func validateConfirmPassword(password: String, confirmPassword: String) -> ValidationResult {
        return Validator.validateConfirmPassword(password, confirmPassword: confirmPassword).mapToVoid()
    }

    func login(email: String, password: String) -> Observable<Void> {
        Future<Void, Error> { promise in
            auth.signIn(withEmail: email, password: password) { _, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }

    func setIsLoggedIn(_ value: Bool) {
        Defaults[.isLoggedIn] = value
    }

    func register(email: String, password: String) -> Observable<Void> {
        Future<Void, Error> { promise in
            auth.createUser(withEmail: email, password: password) { _, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
}
