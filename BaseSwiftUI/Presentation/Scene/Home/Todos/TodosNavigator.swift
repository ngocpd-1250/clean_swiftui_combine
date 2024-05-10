//
//  TodosNavigator.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 09/05/2024.
//

import Foundation
import LinkNavigator

protocol TodosNavigatorType {
    func toAddNew()
}

struct TodosNavigator: TodosNavigatorType {
    let navigation: HomeRootNavigatorType

    func toAddNew() {
        let item = LinkItem(routePath: .newTodo)
        navigation.fullSheet(linkItem: item, isAnimated: true, prefersLargeTitles: false)
    }
}
