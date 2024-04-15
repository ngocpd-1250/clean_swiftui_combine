//
//  AuthRepository.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 19/04/2024.
//

import Foundation

protocol AuthRepository {
    func updateOnboardingStatus(isDone: Bool)
    func validateEmail(email: String) -> ValidationResult
    func validatePassword(password: String) -> ValidationResult
    func validateConfirmPassword(password: String, confirmPassword: String) -> ValidationResult
    func login(email: String, password: String) -> Observable<Void>
    func setIsLoggedIn(_ value: Bool)
    func register(email: String, password: String) -> Observable<Void>
}
