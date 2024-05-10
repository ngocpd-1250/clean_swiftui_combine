//
//  TodosRepository.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 09/05/2024.
//

import Foundation

protocol TodosRepository {
    func getTodoLists() -> Observable<[TodoList]>
    func addTodo(name: String, date: Date, note: String, category: TodoCategory) -> Observable<Void>
    func deleteTodo(item: TodoItem) -> Observable<Void>
}