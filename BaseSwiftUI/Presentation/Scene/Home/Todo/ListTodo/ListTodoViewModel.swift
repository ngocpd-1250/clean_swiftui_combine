//
//  ListTodoViewModel.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 13/05/2024.
//

import Foundation
import Combine
import Factory

struct ListTodoViewModel {
    let navigator: ListTodoNavigatorType
    let category: TodoCategory
    @Injected(\.todoUseCase) var todoUseCase
}

// MARK: - ViewModelType
extension ListTodoViewModel: ViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
        let updateCompleted: Driver<TodoItem>
        let deleteItem: Driver<TodoItem>
    }

    final class Output: ObservableObject {
        @Published var title = ""
        @Published var todoItems: [TodoItem] = []
    }

    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()

        Driver.just(category.name)
            .assign(to: \.title, on: output)
            .cancel(with: cancelBag)

        input.loadTrigger
            .map {
                self.todoUseCase.getTodos(category: category)
                    .asDriver()
            }
            .switchToLatest()
            .assign(to: \.todoItems, on: output)
            .cancel(with: cancelBag)

        input.updateCompleted
            .sink(receiveValue: todoUseCase.updateCompleted(item:))
            .cancel(with: cancelBag)

        input.deleteItem
            .map {
                self.todoUseCase.deleteTodo(item: $0)
                    .asDriver()
            }
            .map { _ in
                self.todoUseCase.getTodos(category: category)
                    .asDriver()
            }
            .switchToLatest()
            .assign(to: \.todoItems, on: output)
            .cancel(with: cancelBag)

        return output
    }
}
