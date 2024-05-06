//
//  SettingsUseCaseMock.swift
//  BaseSwiftUITests
//
//  Created by phan.duong.ngoc on 06/05/2024.
//

@testable import BaseSwiftUI
import Foundation
import Combine

final class SettingsUseCaseMock: SettingsUseCaseType {
    var getCurrentLanguageReturnValue = SupportedLanguage.english.code

    func getCurrentLanguage() -> String {
        return getCurrentLanguageReturnValue
    }

    var getDarkModeStatusReturnValue = false

    func getDarkModeStatus() -> Bool {
        return getDarkModeStatusReturnValue
    }

    var setLanguageCalled = false

    func setLanguage(_ language: String) {
        getCurrentLanguageReturnValue = language
        setLanguageCalled = true
    }

    var toggleDarkModeCalled = false

    func toggleDarkMode() {
        getDarkModeStatusReturnValue.toggle()
        toggleDarkModeCalled = true
    }

    var logoutCalled = false

    func logout() {
        logoutCalled = true
    }
}
