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
    func getTodos(category: TodoCategory) -> Observable<[TodoItem]>
    func addTodo(name: String, date: Date, note: String, category: TodoCategory) -> Observable<Void>
    func deleteTodo(item: TodoItem) -> Observable<Void>
    func updateCompleted(item: TodoItem)
}

struct TodosUseCase: TodosUseCaseType {
    @Injected(\.todosRepository) private var todosRepository

    func getTodoLists() -> Observable<[TodoList]> {
        todosRepository.getTodoLists()
    }

    func getTodos(category: TodoCategory) -> Observable<[TodoItem]> {
        todosRepository.getTodos(category: category)
    }

    func addTodo(name: String, date: Date, note: String, category: TodoCategory) -> Observable<Void> {
        todosRepository.addTodo(name: name, date: date, note: note, category: category)
    }

    func deleteTodo(item: TodoItem) -> Observable<Void> {
        todosRepository.deleteTodo(item: item)
    }

    func updateCompleted(item: TodoItem) {
        todosRepository.updateCompleted(item: item)
    }
}
