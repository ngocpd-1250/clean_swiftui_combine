//
//  TabbarItemType.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 24/04/2024.
//

import Foundation
import UIKit

enum TabBarItemType: Int {
    case movies = 0
    case todos
    case settings

    static let allValues: [TabBarItemType] = [.movies, .todos, .settings]
}

extension TabBarItemType {
    var image: UIImage? {
        switch self {
        case .movies:
            return UIImage(systemName: "house")
        case .todos:
            return UIImage(systemName: "folder")
        case .settings:
            return UIImage(systemName: "person")
        }
    }

    var selectedImage: UIImage? {
        switch self {
        case .movies:
            return UIImage(systemName: "house.fill")
        case .todos:
            return UIImage(systemName: "folder.fill")
        case .settings:
            return UIImage(systemName: "person.fill")
        }
    }

    var title: String? {
        switch self {
        case .movies:
            return R.string.localizable.tabbarMovies()
        case .todos:
            return R.string.localizable.tabbarTodos()
        case .settings:
            return R.string.localizable.tabbarSettings()
        }
    }

    var tabbarItem: UITabBarItem {
        return UITabBarItem(title: title, image: image, selectedImage: selectedImage)
    }
}
