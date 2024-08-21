//
//  ListTodoScreen.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 13/05/2024.
//

import SwiftUI

struct ListTodoScreen: View {
    @ObservedObject private var output: ListTodoViewModel.Output
    private var input: ListTodoViewModel.Input

    private let cancelBag = CancelBag()
    private let updateCompleted = PublishRelay<TodoItem>()
    private let deleteItemTrigger = PublishRelay<TodoItem>()

    var body: some View {
        Screen(title: output.title) {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(output.todoItems) { item in
                        todoItem(item: item)
                            .onTapGesture {
                                updateCompleted.send(item)
                            }
                    }
                }
            }
            .padding()
        }
    }

    @ViewBuilder
    func todoItem(item: TodoItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(formatDate(item.date))
                        .foregroundColor(Color(R.color.primary))
                        .strikethrough(item.isCompleted)

                    Text(item.name)
                        .fontWeight(.bold)
                        .foregroundColor(Color(R.color.labelPrimary))
                        .strikethrough(item.isCompleted)

                    Text(item.note)
                        .foregroundColor(Color(R.color.labelPrimary))
                        .strikethrough(item.isCompleted)
                }
            }
            Spacer()
            VStack {
                Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                    .foregroundColor(item.isCompleted ? Color(R.color.primary) : .gray)
                    .font(.system(size: 25))

                Spacer()
                    .frame(height: Spacing.small.value)

                Button(R.string.localizable.commonDelete()) {
                    deleteItemTrigger.send(item)
                }
                .tint(Color(R.color.primary))
            }
        }
        .padding()
        .background(Color(R.color.todoCardBackground))
        .cornerRadius(10)
    }

    init(viewModel: ListTodoViewModel) {
        let input = ListTodoViewModel.Input(
            loadTrigger: Driver.just(()),
            updateCompleted: updateCompleted.asDriver(),
            deleteItem: deleteItemTrigger.asDriver()
        )
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}
