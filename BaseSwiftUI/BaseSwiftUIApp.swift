//
//  BaseSwiftUIApp.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 15/04/2024.
//

import SwiftUI
import LinkNavigator
import Firebase
import Defaults
import Then

@main
struct BaseSwiftUIApp: App {
    init() {
        FirebaseApp.configure()
        configNavigation()
        configTabbar()
    }

    private func configNavigation() {
        let navigationBar = UINavigationBar.appearance()
        let backImage = R.image.icon_back()

        navigationBar.do {
            $0.isTranslucent = false
            $0.tintColor = R.color.backButtonPrimary()
        }

        let appearance = UINavigationBarAppearance().with {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = R.color.backgroundPrimary()
            $0.shadowColor = .clear
            $0.shadowImage = UIImage()
            $0.titleTextAttributes = [.foregroundColor: R.color.primary() ?? .black]
            $0.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
            // MARK: - clear back title
            $0.backButtonAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.clear]
            $0.backButtonAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.clear]
            $0.backButtonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.clear]
            $0.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        }
        navigationBar.do {
            $0.standardAppearance = appearance
            $0.scrollEdgeAppearance = appearance
        }
    }

    private func configTabbar() {
        let tabBar = UITabBar.appearance()
        tabBar.do {
            $0.tintColor = R.color.primary()
            $0.barTintColor = .black
            $0.unselectedItemTintColor = .gray
            $0.isTranslucent = false
        }
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = R.color.backgroundPrimary()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }

    var body: some Scene {
        MainApp()
    }
}
