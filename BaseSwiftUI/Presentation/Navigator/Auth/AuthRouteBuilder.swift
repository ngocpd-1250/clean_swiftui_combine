//
//  RouteBuilder.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 16/04/2024.
//

import Foundation
import LinkNavigator
import SwiftUI

struct OnboardingRouteBuilder<RootNavigator: AuthRootNavigatorType> {
    static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { RoutePath.onboarding.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            WrappingController(matchPath: matchPath) {
                let navigator = OnboardingNavigator(navigation: navigator)
                let viewModel = OnboardingViewModel(navigator: navigator)
                OnboardingScreen(viewModel: viewModel)
            }
        }
    }
}

struct LoginRouteBuilder<RootNavigator: AuthRootNavigatorType> {
    static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { RoutePath.login.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            WrappingController(matchPath: matchPath) {
                let navigator = LoginNavigator(navigation: navigator)
                let viewModel = LoginViewModel(navigator: navigator)
                LoginScreen(viewModel: viewModel)
            }
        }
    }
}

struct RegisterRouteBuilder<RootNavigator: AuthRootNavigatorType> {
    static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { RoutePath.register.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            WrappingController(matchPath: matchPath) {
                let navigator = RegisterNavigator(navigation: navigator)
                let viewModel = RegisterViewModel(navigator: navigator)
                RegisterScreen(viewModel: viewModel)
            }
        }
    }
}
