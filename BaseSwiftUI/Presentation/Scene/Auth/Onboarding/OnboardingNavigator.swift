//
//  OnboardingNavigator.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 25/04/2024.
//

import Foundation
import LinkNavigator

protocol OnboardingNavigatorType {
    func toLogin()
}

struct OnboardingNavigator: OnboardingNavigatorType {
    let navigation: AuthRootNavigatorType

    func toLogin() {
        navigation.replace(linkItem: .init(routePath: .login), isAnimated: false)
    }
}
