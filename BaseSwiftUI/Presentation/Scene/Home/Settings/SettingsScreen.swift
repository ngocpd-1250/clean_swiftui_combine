//
//  SettingsScreen.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 22/04/2024.
//

import SwiftUI

struct SettingsScreen: View {
    private var input: SettingsViewModel.Input
    @ObservedObject private var output: SettingsViewModel.Output

    private let cancelBag = CancelBag()
    private let logoutTrigger = PublishRelay<Void>()
    private let toggleDarkModeTrigger = PublishRelay<Void>()
    private let toggleLanguageTrigger = PublishRelay<Void>()

    var body: some View {
        Screen {
            ScrollView {
                VStack(spacing: Spacing.normal.value) {
                    SettingItem(title: R.string.localizable.settingsDarkmode(),
                                value: output.isDarkMode) {
                        toggleDarkModeTrigger.send(())
                    }

                    SettingItem(title: R.string.localizable.languageJapanese(),
                                value: output.isJapanese) {
                        toggleLanguageTrigger.send(())
                    }

                    SettingItem(title: R.string.localizable.settingsLogout()) {
                        logoutTrigger.send(())
                    }
                }
                .padding(Spacing.normal.value)
            }
        }
    }

    init(viewModel: SettingsViewModel) {
        let input = SettingsViewModel.Input(loadTrigger: Driver.just(()),
                                            logoutTrigger: logoutTrigger.asDriver(),
                                            toggleDarkModeTrigger: toggleDarkModeTrigger.asDriver(),
                                            toggleLanguageTrigger: toggleLanguageTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}
