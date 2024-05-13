//
//  NewTodoViewModel.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 09/05/2024.
//

import Foundation
import Combine
import Factory

struct NewTodoViewModel {
    let navigator: NewTodoNavigatorType
    @Injected(\.todoUseCase) var todoUseCase
}

// MARK: - ViewModelType
extension NewTodoViewModel: ViewModel {
    final class Input: ObservableObject {
        @Published var note = ""
        @Published var selectedDate = Date()
        @Published var name = ""
        @Published var category = TodoCategory.all

        let loadTrigger: Driver<Void>
        let addTrigger: Driver<Void>
        let closeTrigger: Driver<Void>

        init(loadTrigger: Driver<Void>,
             addTrigger: Driver<Void>,
             closeTrigger: Driver<Void>) {
            self.loadTrigger = loadTrigger
            self.addTrigger = addTrigger
            self.closeTrigger = closeTrigger
        }
    }

    final class Output: ObservableObject {}

    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        input.closeTrigger
            .sink(receiveValue: navigator.close)
            .cancel(with: cancelBag)

        var isValidInput: Bool {
            return !input.name.isEmpty && !input.note.isEmpty
        }

        input.addTrigger
            .filter { !isValidInput }
            .sink(receiveValue: {
                navigator.showError(message: R.string.localizable.validationTodoItemInvalid())
            })
            .cancel(with: cancelBag)

        input.addTrigger
            .filter { isValidInput }
            .map {
                self.todoUseCase.addTodo(name: input.name,
                                         date: input.selectedDate,
                                         note: input.note,
                                         category: input.category)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: navigator.close)
            .cancel(with: cancelBag)

        return Output()
    }
}
