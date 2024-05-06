//
//  RegisterViewModelTests.swift
//  BaseSwiftUITests
//
//  Created by phan.duong.ngoc on 06/05/2024.
//

@testable import BaseSwiftUI
import XCTest
import Combine
import Then

final class RegisterViewModelTests: XCTestCase {
    private var viewModel: RegisterViewModel!
    private var navigator: RegisterNavigatorMock!
    private var useCase: AuthUseCaseMock!

    private var input: RegisterViewModel.Input!
    private var output: RegisterViewModel.Output!
    private var cancelBag: CancelBag!

    private let registerTrigger = PublishRelay<Void>()
    private let toLoginTrigger = PublishRelay<Void>()

    override func setUp() {
        super.setUp()
        navigator = RegisterNavigatorMock()
        useCase = AuthUseCaseMock()
        viewModel = RegisterViewModel(navigator: navigator).with {
            $0.authUseCase = useCase
        }

        input = RegisterViewModel.Input(registerTrigger: registerTrigger.asDriver(),
                                        toLoginTrigger: toLoginTrigger.asDriver())
        cancelBag = CancelBag()
        output = viewModel.transform(input, cancelBag: cancelBag)
    }

    func test_toLoginTrigger_toLogin() {
        // act
        toLoginTrigger.send(())

        // assert
        wait {
            XCTAssertTrue(self.navigator.toLoginCalled)
        }
    }

    func test_registerTrigger_withEmptyEmailEmptyPasswordEmptyConfirmPassword_showError_disableRegisterButton() {
        // act
        input.email = ""
        input.password = ""
        input.confirmPassword = ""
        registerTrigger.send(())

        // assert
        wait {
            XCTAssertEqual(self.output.usernameValidationMessage, R.string.localizable.validationEmailEmpty())
            XCTAssertEqual(self.output.passwordValidationMessage, R.string.localizable.validationPasswordEmpty())
            XCTAssertEqual(self.output.confirmPasswordValidationMessage, R.string.localizable.validationConfirmPasswordEmpty())
            XCTAssertFalse(self.output.isRegisterEnabled)
        }
    }

    func test_registerTrigger_withInvalidEmailInvalidPasword_showError_disableRegisterButton() {
        // act
        input.email = "@gmail.com"
        input.password = "Aa1234"
        input.confirmPassword = "Aa1234"
        registerTrigger.send(())

        // assert
        wait {
            XCTAssertEqual(self.output.usernameValidationMessage, R.string.localizable.validationEmailInvalid())
            XCTAssertEqual(self.output.passwordValidationMessage, R.string.localizable.validationPasswordInvalid())
            XCTAssertEqual(self.output.confirmPasswordValidationMessage, "")
            XCTAssertFalse(self.output.isRegisterEnabled)
        }
    }

    func test_registerTrigger_withConfirmPasswordNotMatch_showError_disableRegisterButton() {
        // act
        input.email = "foo@gmail.com"
        input.password = "Aa@12345"
        input.confirmPassword = "Aa@1234"
        registerTrigger.send(())

        // assert
        wait {
            XCTAssertEqual(self.output.usernameValidationMessage, "")
            XCTAssertEqual(self.output.passwordValidationMessage, "")
            XCTAssertEqual(self.output.confirmPasswordValidationMessage, R.string.localizable.validationConfirmPasswordInvalid())
            XCTAssertFalse(self.output.isRegisterEnabled)
        }
    }

    func test_registerTrigger_withValidInfo_showSuccess() {
        // act
        input.email = "foo@gmail.com"
        input.password = "Aa@12345"
        input.confirmPassword = "Aa@12345"
        registerTrigger.send(())

        // assert
        wait {
            XCTAssertEqual(self.output.usernameValidationMessage, "")
            XCTAssertEqual(self.output.passwordValidationMessage, "")
            XCTAssertEqual(self.output.confirmPasswordValidationMessage, "")
            XCTAssertTrue(self.output.isRegisterEnabled)
            XCTAssertTrue(self.navigator.showRegistrationSuccessCalled)
        }
    }
}
