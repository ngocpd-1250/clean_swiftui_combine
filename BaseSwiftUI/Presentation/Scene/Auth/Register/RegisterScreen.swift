//
//  LoginView.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 15/04/2024.
//

import SwiftUI
import Combine

struct RegisterScreen: View {
    @ObservedObject private var input: RegisterViewModel.Input
    @ObservedObject private var output: RegisterViewModel.Output

    private let cancelBag = CancelBag()
    private let registerTrigger = PublishRelay<Void>()
    private let toLoginTrigger = PublishRelay<Void>()

    var body: some View {
        Screen(isLoading: $output.isLoading) {
            VScrollView {
                VStack {
                    Text(R.string.localizable.commonRegister())
                        .font(.title)
                        .padding(.bottom, Spacing.medium.value)
                        .foregroundStyle(Color(R.color.primary))

                    BaseTextField(text: $input.email,
                                  placeholder: R.string.localizable.commonUsername(),
                                  image: Image(R.image.icon_email),
                                  errorMessage: output.usernameValidationMessage)
                        .padding(.bottom, Spacing.small.value)

                    BaseTextField(text: $input.password,
                                  placeholder: R.string.localizable.commonPassword(),
                                  image: Image(R.image.icon_password),
                                  isSecure: true,
                                  errorMessage: output.passwordValidationMessage)
                        .padding(.bottom, Spacing.small.value)

                    BaseTextField(text: $input.confirmPassword,
                                  placeholder: R.string.localizable.commonConfirmPassword(),
                                  image: Image(R.image.icon_password),
                                  isSecure: true,
                                  errorMessage: output.confirmPasswordValidationMessage)
                        .padding(.bottom, Spacing.small.value)

                    BaseButton(title: R.string.localizable.commonRegister(), isEnabled: output.isRegisterEnabled) {
                        registerTrigger.send(())
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)

                    Text(R.string.localizable.commonAlreadyHaveAccount())
                        .padding(.top, Spacing.extraLarge.value)

                    Button {
                        toLoginTrigger.send(())
                    } label: {
                        Text(R.string.localizable.commonLogin())
                            .foregroundStyle(Color(R.color.primary))
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
    }

    init(viewModel: RegisterViewModel) {
        let input = RegisterViewModel.Input(registerTrigger: registerTrigger.asDriver(),
                                            toLoginTrigger: toLoginTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}
