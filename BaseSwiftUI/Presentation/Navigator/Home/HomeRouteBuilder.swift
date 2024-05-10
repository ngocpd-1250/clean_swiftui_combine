//
//  HomeRouteBuilder.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 22/04/2024.
//

import Foundation
import LinkNavigator
import SwiftUI

// MARK: - MoviesDetailScreen
struct MoviesDetailParams: Codable {
    let id: Int
}

struct MoviesDetailRouteBuilder<RootNavigator: HomeRootNavigatorType> {
    static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { RoutePath.movieDetail.rawValue }
        return .init(matchPath: matchPath) { navigator, items, _ -> RouteViewController? in
            return WrappingController(matchPath: matchPath, title: "") {
                let params: MoviesDetailParams = items.decoded() ?? .init(id: 0)
                let navigator = MovieDetailNavigator(navigation: navigator)
                let viewModel = MovieDetailViewModel(navigator: navigator, id: params.id)
                MovieDetailScreen(viewModel: viewModel)
            }
        }
    }
}

// MARK: - TopMoviesScreen
struct TopMoviesRouteBuilder<RootNavigator: HomeRootNavigatorType> {
    static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { RoutePath.movies.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            return WrappingController(matchPath: matchPath) {
                let navigator = TopMoviesNavigator(navigation: navigator)
                let viewModel = TopMoviesViewModel(navigator: navigator)
                TopMoviesScreen(viewModel: viewModel)
            }
        }
    }
}

// MARK: - TodosScreen
struct TodosRouteBuilder<RootNavigator: HomeRootNavigatorType> {
    static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { RoutePath.todos.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            return WrappingController(matchPath: matchPath) {
                let navigator = TodosNavigator(navigation: navigator)
                let viewModel = TodosViewModel(navigator: navigator)
                TodosScreen(viewModel: viewModel)
            }
        }
    }
}

// MARK: - NewTodoScreen
struct NewTodoRouteBuilder<RootNavigator: HomeRootNavigatorType> {
    static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { RoutePath.newTodo.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            return WrappingController(matchPath: matchPath, title: "") {
                let navigator = NewTodoNavigator(navigation: navigator)
                let viewModel = NewTodoViewModel(navigator: navigator)
                NewTodoScreen(viewModel: viewModel)
            }
        }
    }
}

// MARK: - SettingsScreen
struct SettingsRouteBuilder<RootNavigator: HomeRootNavigatorType> {
    static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { RoutePath.settings.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            WrappingController(matchPath: matchPath, title: "") {
                let navigator = SettingsNavigator(navigation: navigator)
                let viewModel = SettingsViewModel(navigator: navigator)
                SettingsScreen(viewModel: viewModel)
            }
        }
    }
}
