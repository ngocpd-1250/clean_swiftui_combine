//
//  TestError.swift
//  BaseSwiftUITests
//
//  Created by phan.duong.ngoc on 25/04/2024.
//

@testable import BaseSwiftUI
import Foundation

struct TestError: APIError {
    static let message = "Test error message"

    var errorDescription: String? {
        return NSLocalizedString(TestError.message,
                                 value: "",
                                 comment: "")
    }
}

struct AccountBannedError: APIError {
    static let message = "Your account has been banned."

    var errorDescription: String? {
        return NSLocalizedString(AccountBannedError.message,
                                 value: "",
                                 comment: "")
    }
}
