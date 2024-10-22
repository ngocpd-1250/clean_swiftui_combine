//
//  TopMoviesNavigator.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 22/04/2024.
//

import Foundation
import LinkNavigator

protocol TopMoviesNavigatorType {
    func showError(message: String)
    func toMovieDetail(id: Int)
}

struct TopMoviesNavigator: TopMoviesNavigatorType {
    let navigation: HomeRootNavigatorType

    func showError(message: String) {
        let action = ActionButton(title: "OK", style: .cancel)
        let alert = Alert(message: message, buttons: [action], flagType: .error)
        navigation.alert(model: alert)
    }

    func toMovieDetail(id: Int) {
        let item = LinkItem(routePath: .movieDetail, items: MoviesDetailParams(id: id))
        navigation.next(linkItem: item, isAnimated: true)
    }
}
