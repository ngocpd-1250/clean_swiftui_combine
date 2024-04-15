//
//  Spacing.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 25/04/2024.
//

import Foundation

enum Spacing {
    case small
    case normal
    case medium
    case large
    case extraLarge

    var value: CGFloat {
        switch self {
        case .small:
            return 8
        case .normal:
            return 16
        case .medium:
            return 40
        case .large:
            return 70
        case .extraLarge:
            return 100
        }
    }
}
