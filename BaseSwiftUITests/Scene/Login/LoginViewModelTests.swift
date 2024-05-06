//
//  LoginViewModelTests.swift
//  BaseSwiftUITests
//
//  Created by phan.duong.ngoc on 24/04/2024.
//

@testable import BaseSwiftUI
import XCTest
import Combine
import Then

final class LoginViewModelTests: XCTestCase {
    private var viewModel: LoginViewModel!
    private var navigator: LoginNavigatorMock!
    private var useCase: AuthUseCaseMock!

    private var input: LoginViewModel.Input!
    private var output: LoginViewModel.Output!
    private var cancelBag: CancelBag!

    private let loginTrigger = PublishRelay<Void>()
    private let toRegisterTrigger = PublishRelay<Void>()

    override func setUp() {
        super.setUp()
        navigator = LoginNavigatorMock()
        useCase = AuthUseCaseMock()
        viewModel = LoginViewModel(navigator: navigator).with {
            $0.authUseCase = useCase
        }

        input = LoginViewModel.Input(loginTrigger: loginTrigger.asDriver(),
                                     toRegisterTrigger: toRegisterTrigger.asDriver())
        cancelBag = CancelBag()
        output = viewModel.transform(input, cancelBag: cancelBag)
    }

    func test_toRegisterTrigger_toRegister() {
        // act
        toRegisterTrigger.send(())

        // assert
        wait {
            XCTAssertTrue(self.navigator.toRegisterCalled)
        }
    }

    func test_loginTrigger_withEmptyEmailEmptyPassword_showError_disableLoginButton() {
        // act
        input.username = ""
        input.password = ""
        loginTrigger.send(())

        // assert
        wait {
            XCTAssertEqual(self.output.usernameValidationMessage, R.string.localizable.validationEmailEmpty())
            XCTAssertEqual(self.output.passwordValidationMessage, R.string.localizable.validationPasswordEmpty())
            XCTAssertFalse(self.output.isLoginEnabled)
        }
    }

    func test_loginTrigger_withInvalidEmail_showError_disableLoginButton() {
        // act
        input.username = "@gmail.com"
        input.password = "Aa@123456"
        loginTrigger.send(())

        // assert
        wait {
            XCTAssertEqual(self.output.usernameValidationMessage, R.string.localizable.validationEmailInvalid())
            XCTAssertFalse(self.output.isLoginEnabled)
        }
    }

    func test_loginTrigger_withInvalidPassword_showError_disableLoginButton() {
        // act
        input.username = "foo@gmail.com"
        input.password = "Aa@"
        loginTrigger.send(())

        // assert
        wait {
            XCTAssertEqual(self.output.passwordValidationMessage, R.string.localizable.validationPasswordInvalid())
            XCTAssertFalse(self.output.isLoginEnabled)
        }
    }

    func test_loginTrigger_withValidEmailPassword_loginSuccess() {
        // act
        input.username = "foo@gmail.com"
        input.password = "Aa@123456"
        loginTrigger.send(())

        // assert
        wait {
            XCTAssertEqual(self.output.usernameValidationMessage, "")
            XCTAssertEqual(self.output.passwordValidationMessage, "")
            XCTAssertTrue(self.output.isLoginEnabled)
            XCTAssertTrue(self.useCase.isLoggedIn)
        }
    }

    func test_loginTrigger_withValidEmailPassword_accountBannedError_showError() {
        // arrange
        useCase.loginReturnValue = .failure(AccountBannedError())

        // act
        input.username = "foo@gmail.com"
        input.password = "Aa@123456"
        loginTrigger.send(())

        // assert
        wait {
            XCTAssertEqual(self.output.usernameValidationMessage, "")
            XCTAssertEqual(self.output.passwordValidationMessage, "")
            XCTAssertTrue(self.output.isLoginEnabled)
            XCTAssertFalse(self.useCase.isLoggedIn)
            XCTAssertEqual(self.navigator.errorMessage, AccountBannedError.message)
            XCTAssertTrue(self.navigator.showErrorCalled)
        }
    }
}
