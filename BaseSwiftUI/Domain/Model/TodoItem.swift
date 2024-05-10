//
//  TodoItem.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 10/05/2024.
//

import Foundation
import SwiftData

@Model class TodoItem {
    var id: String
    var name: String
    var note: String
    var category: TodoCategory
    var isCompleted = false
    var date: Date

    init(id: String = UUID().uuidString, name: String, note: String, category: TodoCategory, isCompleted: Bool = false, date: Date) {
        self.id = id
        self.name = name
        self.note = note
        self.category = category
        self.isCompleted = isCompleted
        self.date = date
    }
}
