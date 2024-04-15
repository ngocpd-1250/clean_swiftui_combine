//
//  SettingsUseCase.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 24/04/2024.
//

import Foundation
import Factory

protocol SettingsUseCaseType {
    func getCurrentLanguage() -> String
    func getDarkModeStatus() -> Bool
    func setLanguage(_ language: String)
    func toggleDarkMode()
    func logout()
}

struct SettingsUseCase: SettingsUseCaseType {
    @Injected(\.settingsRepository) private var settingsRepository

    func getCurrentLanguage() -> String {
        settingsRepository.getCurrentLanguage()
    }

    func getDarkModeStatus() -> Bool {
        settingsRepository.getDarkModeStatus()
    }

    func setLanguage(_ language: String) {
        settingsRepository.setLanguage(language)
    }

    func toggleDarkMode() {
        settingsRepository.toggleDarkMode()
    }

    func logout() {
        settingsRepository.logout()
    }
}
