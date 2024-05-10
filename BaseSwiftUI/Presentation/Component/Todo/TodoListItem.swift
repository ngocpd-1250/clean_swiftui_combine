//
//  TodoListItem.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 10/05/2024.
//

import SwiftUI

struct TodoListItem: View {
    var taskList: TodoList

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Image(taskList.category.image)
                    .resizable()
                    .frame(width: 30, height: 30)

                Spacer()
                    .frame(height: 20)

                VStack(alignment: .leading) {
                    Text(taskList.category.name)
                        .fontWeight(.medium)
                        .foregroundColor(Color(R.color.labelPrimary))

                    Text("\(taskList.items.count) \(R.string.localizable.commonTasks())")
                        .foregroundColor(Color(R.color.labelPrimary))
                }
            }
            Spacer()
        }
        .frame(width: 140, height: 140)
        .padding(.horizontal)
        .background(Color(R.color.todoCardBackground))
        .cornerRadius(10)
    }
}
