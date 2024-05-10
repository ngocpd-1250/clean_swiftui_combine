//
//  TodosRepositoryImpl.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 09/05/2024.
//

import Foundation
import Combine
import Factory
import SwiftData

struct TodosRepositoryImpl: TodosRepository {
    @Injected(\.modelContext) private var modelContext

    func addTodo(name: String, date: Date, note: String, category: TodoCategory) -> Observable<Void> {
        Future<Void, Error> { promise in
            do {
                let item = TodoItem(name: name, note: note, category: category, date: date)
                modelContext?.insert(item)
                try modelContext?.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    func getTodoLists() -> Observable<[TodoList]> {
        Future<[TodoList], Error> { promise in
            do {
                let descriptor = FetchDescriptor<TodoItem>()
                let items = try modelContext?.fetch(descriptor) ?? []
                promise(.success(groupTodoItemsToTodoLists(items: items)))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    func deleteTodo(item: TodoItem) -> Observable<Void> {
        Future<Void, Error> { promise in
            do {
                modelContext?.delete(item)
                try modelContext?.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    private func groupTodoItemsToTodoLists(items: [TodoItem]) -> [TodoList] {
        var dict: [TodoCategory: TodoList] = [:]

        for todoItem in items {
            dict[todoItem.category, default: TodoList(category: todoItem.category)].items.append(todoItem)
        }

        return Array(dict.values)
    }
}
