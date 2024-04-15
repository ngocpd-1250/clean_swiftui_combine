//
//  LoginViewModel.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 19/04/2024.
//

import Foundation
import Factory
import Combine

struct LoginViewModel {
    let navigator: LoginNavigatorType
    @Injected(\.authUseCase) var authUseCase
}

// MARK: - ViewModelType
extension LoginViewModel: ViewModel {
    final class Input: ObservableObject {
        @Published var username = ""
        @Published var password = ""
        let loginTrigger: Driver<Void>
        let toRegisterTrigger: Driver<Void>

        init(loginTrigger: Driver<Void>, toRegisterTrigger: Driver<Void>) {
            self.loginTrigger = loginTrigger
            self.toRegisterTrigger = toRegisterTrigger
        }
    }

    final class Output: ObservableObject {
        @Published var isLoginEnabled = true
        @Published var isLoading = false
        @Published var usernameValidationMessage = ""
        @Published var passwordValidationMessage = ""
    }

    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker()
        let output = Output()

        let usernameValidation = Publishers
            .CombineLatest(input.$username, input.loginTrigger)
            .map { $0.0 }
            .map(authUseCase.validateEmail(email:))

        usernameValidation
            .asDriver()
            .map { $0.message }
            .assign(to: \.usernameValidationMessage, on: output)
            .cancel(with: cancelBag)

        let passwordValidation = Publishers
            .CombineLatest(input.$password, input.loginTrigger)
            .map { $0.0 }
            .map(authUseCase.validatePassword(password:))

        passwordValidation
            .asDriver()
            .map { $0.message }
            .assign(to: \.passwordValidationMessage, on: output)
            .cancel(with: cancelBag)

        Publishers
            .CombineLatest(usernameValidation, passwordValidation)
            .map { $0.0.isValid && $0.1.isValid }
            .assign(to: \.isLoginEnabled, on: output)
            .cancel(with: cancelBag)

        input.loginTrigger
            .delay(for: 0.1, scheduler: RunLoop.main)
            .filter { output.isLoginEnabled }
            .map { _ in
                self.authUseCase.login(email: input.username, password: input.password)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: {
                authUseCase.setIsLoggedIn(true)
            })
            .cancel(with: cancelBag)

        input.toRegisterTrigger
            .sink(receiveValue: navigator.toRegister)
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
