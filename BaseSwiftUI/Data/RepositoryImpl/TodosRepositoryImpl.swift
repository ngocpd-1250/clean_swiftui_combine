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
                let item = TodoItem(name: name, note: note, categoryId: category.id, date: date)
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

    func getTodos(category: TodoCategory) -> Observable<[TodoItem]> {
        Future<[TodoItem], Error> { promise in
            do {
                let descriptor = FetchDescriptor<TodoItem>(predicate: #Predicate {
                    $0.categoryId == category.id
                })
                let items = try modelContext?.fetch(descriptor) ?? []
                promise(.success(items))
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

    func updateCompleted(item: TodoItem) {
        item.isCompleted.toggle()
    }

    private func groupTodoItemsToTodoLists(items: [TodoItem]) -> [TodoList] {
        var dict: [TodoCategory: TodoList] = [:]

        for todoItem in items {
            dict[TodoCategory.byId(todoItem.categoryId), default: TodoList(category: TodoCategory.byId(todoItem.categoryId))].items.append(todoItem)
        }

        return Array(dict.values)
    }
}
