//
//  RegisterViewModel.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 21/04/2024.
//

import Foundation
import Factory
import Combine

struct RegisterViewModel {
    let navigator: RegisterNavigatorType
    @Injected(\.authUseCase) var authUseCase
}

// MARK: - ViewModelType
extension RegisterViewModel: ViewModel {
    final class Input: ObservableObject {
        @Published var email = ""
        @Published var password = ""
        @Published var confirmPassword = ""

        let registerTrigger: Driver<Void>
        let toLoginTrigger: Driver<Void>

        init(registerTrigger: Driver<Void>, toLoginTrigger: Driver<Void>) {
            self.registerTrigger = registerTrigger
            self.toLoginTrigger = toLoginTrigger
        }
    }

    final class Output: ObservableObject {
        @Published var isRegisterEnabled = true
        @Published var isLoading = false
        @Published var usernameValidationMessage = ""
        @Published var passwordValidationMessage = ""
        @Published var confirmPasswordValidationMessage = ""
    }

    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker()
        let output = Output()

        let usernameValidation = Publishers
            .CombineLatest(input.$email, input.registerTrigger)
            .map { $0.0 }
            .map(authUseCase.validateEmail(email:))

        usernameValidation
            .asDriver()
            .map { $0.message }
            .assign(to: \.usernameValidationMessage, on: output)
            .cancel(with: cancelBag)

        let passwordValidation = Publishers
            .CombineLatest(input.$password, input.registerTrigger)
            .map { $0.0 }
            .map(authUseCase.validatePassword(password:))

        passwordValidation
            .asDriver()
            .map { $0.message }
            .assign(to: \.passwordValidationMessage, on: output)
            .cancel(with: cancelBag)

        let confirmPasswordValidation = Publishers
            .CombineLatest3(input.$password.prepend(""), input.$confirmPassword, input.registerTrigger)
            .map {
                authUseCase.validateConfirmPassword(password: $0.0, confirmPassword: $0.1)
            }

        confirmPasswordValidation
            .asDriver()
            .map { $0.message }
            .assign(to: \.confirmPasswordValidationMessage, on: output)
            .cancel(with: cancelBag)

        Publishers
            .CombineLatest3(usernameValidation, passwordValidation, confirmPasswordValidation)
            .map { $0.0.isValid && $0.1.isValid && $0.2.isValid }
            .assign(to: \.isRegisterEnabled, on: output)
            .cancel(with: cancelBag)

        input.registerTrigger
            .delay(for: 0.1, scheduler: RunLoop.main)
            .filter { output.isRegisterEnabled }
            .map { _ in
                self.authUseCase.register(email: input.email, password: input.password)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: navigator.showRegistrationSuccess)
            .cancel(with: cancelBag)

        input.toLoginTrigger
            .sink(receiveValue: navigator.toLogin)
            .cancel(with: cancelBag)

        activityTracker.isLoading
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .cancel(with: cancelBag)

        errorTracker
            .receive(on: RunLoop.main)
            .unwrap()
            .sink(receiveValue: { error in
                navigator.showError(message: error.localizedDescription)
            })
            .cancel(with: cancelBag)

        return output
    }
}
