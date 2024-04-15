//
//  Language.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 24/04/2024.
//

import Foundation

enum SupportedLanguage {
    case japanese
    case english

    var code: String {
        switch self {
        case .english:
            return "en"
        case .japanese:
            return "ja"
        }
    }
}
