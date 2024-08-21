//
//  OnboardingViewModel.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 25/04/2024.
//

import Foundation
import Factory
import Combine

struct OnboardingViewModel {
    let navigator: OnboardingNavigatorType
    @Injected(\.authUseCase) var authUseCase
}

// MARK: - ViewModelType
extension OnboardingViewModel: ViewModel {
    struct Input {
        let setIsDoneOnboarding: Driver<Void>
    }

    final class Output: ObservableObject {}

    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()

        input.setIsDoneOnboarding
            .sink(receiveValue: {
                authUseCase.updateOnboardingStatus(isDone: true)
                navigator.toLogin()
            })
            .cancel(with: cancelBag)

        return output
    }
}
