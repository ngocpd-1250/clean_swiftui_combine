//
//  TodoCategory.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 10/05/2024.
//

import SwiftData
import Foundation

enum TodoCategory: String, CaseIterable, Identifiable, Codable {
    case all
    case cooking
    case finance
    case gift
    case health
    case home
    case ideas
    case music
    case others
    case payment
    case shopping
    case study
    case travel
    case work

    var name: String {
        return rawValue.prefix(1).capitalized + rawValue.dropFirst()
    }

    var image: String {
        return "task_\(rawValue)"
    }

    var id: String {
        return rawValue
    }
}
