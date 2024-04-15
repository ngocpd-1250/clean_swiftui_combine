//
//  HomeRouteGroup.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 22/04/2024.
//

import LinkNavigator

public typealias HomeRootNavigatorType = LinkNavigatorFindLocationUsable & TabLinkNavigatorProtocol

// MARK: - AppRouterBuilderGroup

struct HomeRouteGroup<RootNavigator: HomeRootNavigatorType> {
    init() {}

    var routers: [RouteBuilderOf<RootNavigator>] {
        [
            MoviesRouteBuilder.generate(),
            MoviesDetailRouteBuilder.generate(),
            TodosRouteBuilder.generate(),
            SettingsRouteBuilder.generate()
        ]
    }
}
