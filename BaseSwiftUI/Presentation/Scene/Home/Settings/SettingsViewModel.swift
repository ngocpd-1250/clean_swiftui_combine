//
//  SettingsViewModel.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 24/04/2024.
//

import Foundation
import Factory
import Combine

struct SettingsViewModel {
    let navigator: SettingsNavigatorType
    @Injected(\.settingsUseCase) var settingsUseCase
}

// MARK: - ViewModelType
extension SettingsViewModel: ViewModel {
    final class Input: ObservableObject {
        let loadTrigger: Driver<Void>
        let logoutTrigger: Driver<Void>
        let toggleDarkModeTrigger: Driver<Void>
        let toggleLanguageTrigger: Driver<Void>

        init(loadTrigger: Driver<Void>,
             logoutTrigger: Driver<Void>,
             toggleDarkModeTrigger: Driver<Void>,
             toggleLanguageTrigger: Driver<Void>) {
            self.loadTrigger = loadTrigger
            self.logoutTrigger = logoutTrigger
            self.toggleDarkModeTrigger = toggleDarkModeTrigger
            self.toggleLanguageTrigger = toggleLanguageTrigger
        }
    }

    final class Output: ObservableObject {
        @Published var isJapanese = false
        @Published var isDarkMode = false
    }

    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()

        input.loadTrigger
            .map {
                self.settingsUseCase.getCurrentLanguage() == SupportedLanguage.japanese.code
            }
            .assign(to: \.isJapanese, on: output)
            .cancel(with: cancelBag)

        input.loadTrigger
            .map {
                self.settingsUseCase.getDarkModeStatus()
            }
            .assign(to: \.isDarkMode, on: output)
            .cancel(with: cancelBag)

        input.toggleDarkModeTrigger
            .map {
                self.settingsUseCase.toggleDarkMode()
            }
            .map {
                self.settingsUseCase.getDarkModeStatus()
            }
            .assign(to: \.isDarkMode, on: output)
            .cancel(with: cancelBag)

        input.toggleLanguageTrigger
            .map {
                let current = self.settingsUseCase.getCurrentLanguage()
                let newLanguage = current == SupportedLanguage.japanese.code ? SupportedLanguage.english.code : SupportedLanguage.japanese.code
                self.settingsUseCase.setLanguage(newLanguage)
            }
            .map {
                self.settingsUseCase.getCurrentLanguage() == SupportedLanguage.japanese.code
            }
            .assign(to: \.isJapanese, on: output)
            .cancel(with: cancelBag)

        input.logoutTrigger
            .map {
                self.settingsUseCase.logout()
            }
            .sink(receiveValue: {})
            .cancel(with: cancelBag)

        return output
    }
}
