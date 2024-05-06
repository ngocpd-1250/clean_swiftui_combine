//
//  SettingsViewModelTests.swift
//  BaseSwiftUITests
//
//  Created by phan.duong.ngoc on 06/05/2024.
//

@testable import BaseSwiftUI
import XCTest
import Combine

final class SettingsViewModelTests: XCTestCase {
    private var viewModel: SettingsViewModel!
    private var navigator: SettingsNavigatorMock!
    private var useCase: SettingsUseCaseMock!

    private var input: SettingsViewModel.Input!
    private var output: SettingsViewModel.Output!
    private var cancelBag: CancelBag!

    private let loadTrigger = PublishRelay<Void>()
    private let logoutTrigger = PublishRelay<Void>()
    private let toggleDarkModeTrigger = PublishRelay<Void>()
    private let toggleLanguageTrigger = PublishRelay<Void>()

    override func setUp() {
        super.setUp()
        navigator = SettingsNavigatorMock()
        useCase = SettingsUseCaseMock()
        viewModel = SettingsViewModel(navigator: navigator).with {
            $0.settingsUseCase = useCase
        }

        input = SettingsViewModel.Input(loadTrigger: loadTrigger.asDriver(),
                                        logoutTrigger: logoutTrigger.asDriver(),
                                        toggleDarkModeTrigger: toggleDarkModeTrigger.asDriver(),
                                        toggleLanguageTrigger: toggleLanguageTrigger.asDriver())
        cancelBag = CancelBag()
        output = viewModel.transform(input, cancelBag: cancelBag)
    }

    func test_logoutTrigger_logout() {
        // act
        logoutTrigger.send(())

        // assert
        wait {
            XCTAssertTrue(self.useCase.logoutCalled)
        }
    }

    func test_loadTrigger_getDarkModeStatusAndCurrentLanguage() {
        // act
        loadTrigger.send(())

        // assert
        wait {
            XCTAssertEqual(self.output.isJapanese, false)
            XCTAssertEqual(self.output.isDarkMode, false)
        }
    }

    func test_toggleDarkModeTrigger_toggleDarkModeStatus() {
        // act
        useCase.getDarkModeStatusReturnValue = false
        toggleDarkModeTrigger.send(())

        // assert
        wait {
            XCTAssertEqual(self.output.isDarkMode, true)
        }
    }

    func test_toggleLanguageTrigger_toggleLanguage() {
        // act
        useCase.getCurrentLanguageReturnValue = SupportedLanguage.english.code
        toggleLanguageTrigger.send(())

        // assert
        wait {
            XCTAssertEqual(self.output.isJapanese, true)
        }
    }
}
