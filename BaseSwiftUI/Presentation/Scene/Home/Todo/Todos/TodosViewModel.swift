//
//  TodosViewModel.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 09/05/2024.
//

import Foundation
import Combine
import Factory

struct TodosViewModel {
    let navigator: TodosNavigatorType
    @Injected(\.todoUseCase) var todoUseCase
}

// MARK: - ViewModelType
extension TodosViewModel: ViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
        let toAddNew: Driver<Void>
        let toTodoItems: Driver<TodoCategory>
    }

    final class Output: ObservableObject {
        @Published var todoLists: [TodoList] = []
    }

    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()

        input.toAddNew
            .sink(receiveValue: navigator.toAddNew)
            .cancel(with: cancelBag)

        input.toTodoItems
            .sink(receiveValue: navigator.toTodoItems(category:))
            .cancel(with: cancelBag)

        input.loadTrigger
            .map {
                self.todoUseCase.getTodoLists()
                    .asDriver()
            }
            .switchToLatest()
            .assign(to: \.todoLists, on: output)
            .cancel(with: cancelBag)

        return output
    }
}
