//
//  Domain+Injection.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 19/04/2024.
//

import Factory

extension Container {
    var authUseCase: Factory<AuthUseCaseType> {
        Factory(self) { AuthUseCase() }
    }

    var movieUseCase: Factory<MovieUseCaseType> {
        Factory(self) { MovieUseCase() }
    }

    var settingsUseCase: Factory<SettingsUseCaseType> {
        Factory(self) { SettingsUseCase() }
    }

    var todoUseCase: Factory<TodosUseCaseType> {
        Factory(self) { TodosUseCase() }
    }
}
