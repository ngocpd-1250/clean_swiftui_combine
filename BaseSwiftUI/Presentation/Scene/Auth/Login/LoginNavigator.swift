//
//  LoginNavigator.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 19/04/2024.
//

import Foundation
import LinkNavigator

protocol LoginNavigatorType {
    func toRegister()
    func showError(message: String)
}

struct LoginNavigator: LoginNavigatorType {
    let navigation: AuthRootNavigatorType

    func toRegister() {
        navigation.next(linkItem: .init(routePath: .register), isAnimated: true)
    }

    func showError(message: String) {
        let action = ActionButton(title: "OK", style: .cancel)
        let alert = Alert(message: message, buttons: [action], flagType: .error)
        navigation.alert(target: .root, model: alert)
    }
}
