//
//  MainApp.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 24/04/2024.
//

import SwiftUI
import Defaults
import LinkNavigator
import Then

struct MainApp: Scene {
    @Default(.isLoggedIn) var isLoggedIn
    @Default(.isDarkMode) var isDarkMode

    var body: some Scene {
        WindowGroup {
            if NSClassFromString("XCTest") != nil {
                unitTestView()
            } else {
                if isLoggedIn {
                    HomeRoute()
                } else {
                    AuthRoute()
                }
            }
        }
    }

    @ViewBuilder
    func unitTestView() -> some View {
        VStack {
            Text("Testing...")
                .font(.title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

private struct AuthRoute: View {
    private let linkNavigator = SingleLinkNavigator(
        routeBuilderItemList: AuthRouteGroup().routers,
        dependency: NavigatorDependency())

    var body: some View {
        LinkNavigationView(
            linkNavigator: linkNavigator,
            item: .init(routePath: Defaults[.isOnboardingCompleted] ? RoutePath.login : RoutePath.onboarding)
        )
        .background(Color(R.color.backgroundPrimary))
        .onOpenURL { url in
            // You can test deep links by setting the URL Scheme to "testlink".
            // Example: testlink://host?email=foo@gmail.com&password=Aa@12345
            let action = ActionButton(title: "OK", style: .cancel)
            let alert = Alert(title: "Deeplink URL:", message: url.absoluteString, buttons: [action], flagType: .error)
            linkNavigator.alert(target: .root, model: alert)
        }
    }
}

private struct HomeRoute: View {
    @Default(.language) var language

    private let tabLinkNavigator = TabLinkNavigator(
        routeBuilderItemList: HomeRouteGroup().routers,
        dependency: NavigatorDependency())

    private let tabItems: [TabItem] = [
        .init(
            tag: TabBarItemType.movies.rawValue,
            tabItem: TabBarItemType.movies.tabbarItem,
            linkItem: .init(routePath: .movies)),
        .init(
            tag: TabBarItemType.todos.rawValue,
            tabItem: TabBarItemType.todos.tabbarItem,
            linkItem: .init(routePath: .todos)),
        .init(
            tag: TabBarItemType.settings.rawValue,
            tabItem: TabBarItemType.settings.tabbarItem,
            linkItem: .init(routePath: .settings))
    ]

    var body: some View {
        return TabLinkNavigationView(
            linkNavigator: tabLinkNavigator,
            isHiddenDefaultTabbar: false,
            tabItemList: tabItems,
            isAnimatedForUpdateTabbar: false
        )
        .background(Color(R.color.backgroundPrimary))
        .onAppear {
            observerLanguageChange()
        }
    }

    private func observerLanguageChange() {
        Task {
            for await _ in Defaults.updates(.language) {
                reloadTabbarTitle()
            }
        }
    }

    private func reloadTabbarTitle() {
        let tabbarItems = tabLinkNavigator.mainController?.tabBar.items
        tabbarItems?.do {
            $0[TabBarItemType.movies.rawValue].title = TabBarItemType.movies.title
            $0[TabBarItemType.todos.rawValue].title = TabBarItemType.todos.title
            $0[TabBarItemType.settings.rawValue].title = TabBarItemType.settings.title
        }
    }
}
