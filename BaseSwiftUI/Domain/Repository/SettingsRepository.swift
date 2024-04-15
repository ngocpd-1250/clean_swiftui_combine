//
//  SettingsRepository.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 24/04/2024.
//

import Foundation

protocol SettingsRepository {
    func getCurrentLanguage() -> String
    func getDarkModeStatus() -> Bool
    func setLanguage(_ language: String)
    func toggleDarkMode()
    func logout()
}
