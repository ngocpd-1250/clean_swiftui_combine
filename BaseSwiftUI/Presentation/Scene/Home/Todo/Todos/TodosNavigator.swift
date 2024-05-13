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
    func toTodoItems(category: TodoCategory)
}

struct TodosNavigator: TodosNavigatorType {
    let navigation: HomeRootNavigatorType

    func toAddNew() {
        let item = LinkItem(routePath: .newTodo)
        navigation.fullSheet(linkItem: item, isAnimated: true, prefersLargeTitles: false)
    }

    func toTodoItems(category: TodoCategory) {
        let item = LinkItem(routePath: .todoList, items: ListTodoParams(category: category))
        navigation.next(linkItem: item, isAnimated: true)
    }
}
