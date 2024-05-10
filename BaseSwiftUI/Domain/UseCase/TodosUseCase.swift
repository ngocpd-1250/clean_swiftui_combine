//
//  TodosUseCase.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 09/05/2024.
//

import Foundation
import Factory

protocol TodosUseCaseType {
    func getTodoLists() -> Observable<[TodoList]>
    func addTodo(name: String, date: Date, note: String, category: TodoCategory) -> Observable<Void>
    func deleteTodo(item: TodoItem) -> Observable<Void>
}

struct TodosUseCase: TodosUseCaseType {
    @Injected(\.todosRepository) private var todosRepository

    func getTodoLists() -> Observable<[TodoList]> {
        todosRepository.getTodoLists()
    }

    func addTodo(name: String, date: Date, note: String, category: TodoCategory) -> Observable<Void> {
        todosRepository.addTodo(name: name, date: date, note: note, category: category)
    }

    func deleteTodo(item: TodoItem) -> Observable<Void> {
        todosRepository.deleteTodo(item: item)
    }
}
