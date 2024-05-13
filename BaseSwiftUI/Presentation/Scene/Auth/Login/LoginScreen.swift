//
//  LoginView.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 15/04/2024.
//

import SwiftUI

struct LoginScreen: View {
    @ObservedObject var input: LoginViewModel.Input
    @ObservedObject var output: LoginViewModel.Output

    private let cancelBag = CancelBag()
    private let loginTrigger = PublishRelay<Void>()
    private let toRegisterTrigger = PublishRelay<Void>()

    var body: some View {
        return Screen(isLoading: $output.isLoading) {
            VScrollView {
                VStack {
                    Text(R.string.localizable.commonLogin())
                        .font(.title)
                        .padding(.bottom, Spacing.medium.value)
                        .foregroundStyle(Color(R.color.primary))

                    BaseTextField(text: $input.username,
                                  placeholder: R.string.localizable.commonUsername(),
                                  image: Image(R.image.icon_email),
                                  errorMessage: output.usernameValidationMessage)
                        .padding(.bottom)

                    BaseTextField(text: $input.password,
                                  placeholder: R.string.localizable.commonPassword(),
                                  image: Image(R.image.icon_password),
                                  isSecure: true,
                                  errorMessage: output.passwordValidationMessage)
                        .padding(.bottom)

                    BaseButton(title: R.string.localizable.commonLogin(), isEnabled: output.isLoginEnabled) {
                        loginTrigger.send(())
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .padding(.top, Spacing.normal.value)

                    Text(R.string.localizable.commonDontHaveAccount())
                        .padding(.top, Spacing.extraLarge.value)

                    Button {
                        toRegisterTrigger.send(())
                    } label: {
                        Text(R.string.localizable.commonRegister())
                            .foregroundStyle(Color(R.color.primary))
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
    }

    init(viewModel: LoginViewModel) {
        let input = LoginViewModel.Input(loginTrigger: loginTrigger.asDriver(),
                                         toRegisterTrigger: toRegisterTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}
