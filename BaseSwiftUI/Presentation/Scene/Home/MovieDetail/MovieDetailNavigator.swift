//
//  MovieDetailNavigator.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 23/04/2024.
//

import Foundation
import LinkNavigator

protocol MovieDetailNavigatorType {
    func showError(message: String)
}

struct MovieDetailNavigator: MovieDetailNavigatorType {
    let navigation: HomeRootNavigatorType

    func showError(message: String) {
        let action = ActionButton(title: "OK", style: .cancel)
        let alert = Alert(message: message, buttons: [action], flagType: .error)
        navigation.alert(model: alert)
    }
}
