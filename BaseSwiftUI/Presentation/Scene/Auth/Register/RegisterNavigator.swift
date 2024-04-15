//
//  RegisterNavigator.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 21/04/2024.
//

import Foundation
import LinkNavigator

protocol RegisterNavigatorType {
    func toLogin()
    func showError(message: String)
    func showRegistrationSuccess()
}

struct RegisterNavigator: RegisterNavigatorType {
    let navigation: AuthRootNavigatorType

    func toLogin() {
        navigation.backOrNext(linkItem: .init(routePath: .login), isAnimated: true)
    }

    func showError(message: String) {
        let action = ActionButton(title: "OK", style: .cancel)
        let alert = Alert(message: message, buttons: [action], flagType: .error)
        navigation.alert(target: .root, model: alert)
    }

    func showRegistrationSuccess() {
        let action = ActionButton(title: "OK", style: .default) {
            navigation.backOrNext(linkItem: .init(routePath: .login), isAnimated: true)
        }
        let alert = Alert(message: "Registration complete! Please sign in.", buttons: [action], flagType: .default)
        navigation.alert(target: .root, model: alert)
    }
}
