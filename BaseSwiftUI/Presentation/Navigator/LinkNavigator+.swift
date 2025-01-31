//
//  LinkNavigator+.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 17/04/2024.
//

import LinkNavigator

extension TabLinkNavigator {
    var selectedTabPartialNavigator: TabPartialNavigator {
        return tabRootPartialNavigators[mainController?.selectedIndex ?? 0]
    }
}

extension LinkItem {
    init(routePaths: [RoutePath], items: String = "") {
        self.init(pathList: routePaths.map { $0.rawValue }, itemsString: items)
    }

    init(routePath: RoutePath, items: String = "") {
        self.init(path: routePath.rawValue, itemsString: items)
    }

    init(routePath: RoutePath, items: Codable?) {
        self.init(path: routePath.rawValue, items: items)
    }

    init(routePaths: [RoutePath], items: Codable?) {
        self.init(pathList: routePaths.map { $0.rawValue }, items: items)
    }
}
