//
//  ActivityTracker.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 19/04/2024.
//

import Combine
import Then

public protocol ViewModel: Then {
    associatedtype Input
    associatedtype Output

    func transform(_ input: Input, cancelBag: CancelBag) -> Output
}
