//
//  AuthRouteGroup.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 16/04/2024.
//

import LinkNavigator

public typealias AuthRootNavigatorType = LinkNavigatorFindLocationUsable & LinkNavigatorProtocol

// MARK: - AppRouterBuilderGroup
struct AuthRouteGroup<RootNavigator: AuthRootNavigatorType> {
    init() {}

    var routers: [RouteBuilderOf<RootNavigator>] {
        [
            OnboardingRouteBuilder.generate(),
            LoginRouteBuilder.generate(),
            RegisterRouteBuilder.generate()
        ]
    }
}
