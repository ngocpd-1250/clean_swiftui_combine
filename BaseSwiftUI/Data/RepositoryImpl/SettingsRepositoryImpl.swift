//
//  SettingsRepositoryImpl.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 24/04/2024.
//

import Foundation
import Defaults

struct SettingsRepositoryImpl: SettingsRepository {
    func getCurrentLanguage() -> String {
        Defaults[.language]
    }

    func getDarkModeStatus() -> Bool {
        Defaults[.isDarkMode]
    }

    func setLanguage(_ language: String) {
        Defaults[.language] = language
    }

    func toggleDarkMode() {
        Defaults[.isDarkMode].toggle()
    }

    func logout() {
        Defaults[.isLoggedIn] = false
    }
}
