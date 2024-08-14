//
//  TodosScreen.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 22/04/2024.
//

import SwiftUI
import Defaults
import Combine

struct TodosScreen: View {
    @ObservedObject var input: TodosViewModel.Input
    @ObservedObject var output: TodosViewModel.Output

    private let cancelBag = CancelBag()
    private let loadTrigger = PublishRelay<Void>()
    private let toAddNew = PublishRelay<Void>()
    private let toTodoItems = PublishRelay<TodoCategory>()

    var body: some View {
        Screen(title: R.string.localizable.todoTitle()) {
            ZStack {
                if output.todoLists.isEmpty {
                    emptyView()
                } else {
                    todoListView()
                }
                addNewButton()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            loadTrigger.send(())
        }
    }

    @ViewBuilder
    func todoListView() -> some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 200),
                                             spacing: Spacing.normal.value)],
                          content: {
                              ForEach(output.todoLists, id: \.category.id) { todo in
                                  TodoListItem(todoList: todo)
                                      .onTapGesture {
                                          print("onTapGesture \(todo.category.id)")
                                          toTodoItems.send(todo.category)
                                      }
                              }
                          })
                          .id(Defaults[.language])
                Spacer()
            }
            .padding()
        }
    }

    @ViewBuilder
    func emptyView() -> some View {
        Image(R.image.todos_empty)
            .resizable()
            .frame(width: 200, height: 200, alignment: .center)
            .padding(.bottom, 40)
    }

    @ViewBuilder
    func addNewButton() -> some View {
        VStack {
            Spacer()

            HStack {
                Spacer()

                Button(action: {
                    toAddNew.send(())
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding()
                        .tint(Color(R.color.primary))
                })
            }
        }
    }

    init(viewModel: TodosViewModel) {
        let input = TodosViewModel.Input(
            loadTrigger: Publishers.Merge(
                Driver.just(()),
                loadTrigger.asDriver()
            )
            .asDriver(),
            toAddNew: toAddNew.asDriver(),
            toTodoItems: toTodoItems.asDriver()
        )
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}
