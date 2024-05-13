//
//  NewTodoNavigator.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 09/05/2024.
//

import Foundation
import LinkNavigator

protocol NewTodoNavigatorType {
    func close()
    func showError(message: String)
}

struct NewTodoNavigator: NewTodoNavigatorType {
    let navigation: HomeRootNavigatorType

    func close() {
        navigation.close(isAnimated: true, completeAction: {})
    }

    func showError(message: String) {
        let action = ActionButton(title: "OK", style: .cancel)
        let alert = Alert(message: message, buttons: [action], flagType: .error)
        navigation.alert(model: alert)
    }
}
