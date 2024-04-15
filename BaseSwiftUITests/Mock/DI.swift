//
//  DI.swift
//  BaseSwiftUITests
//
//  Created by phan.duong.ngoc on 24/04/2024.
//

@testable import BaseSwiftUI
import Factory

extension Container {
    var authUseCase: Factory<AuthUseCaseType> {
        Factory(self) { AuthUseCaseMock() }
    }
}
