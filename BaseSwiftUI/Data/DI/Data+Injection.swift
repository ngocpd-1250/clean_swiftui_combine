//
//  Data+Injection.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 19/04/2024.
//

import Factory
import FirebaseAuth
import SwiftData

extension Container {
    var auth: Factory<Auth> {
        Factory(self) { Auth.auth() }
    }

    var authRepository: Factory<AuthRepository> {
        Factory(self) { AuthRepositoryImpl() }
    }

    var movieRepository: Factory<MovieRepository> {
        Factory(self) { MovieRepositoryImpl() }
    }

    var settingsRepository: Factory<SettingsRepository> {
        Factory(self) { SettingsRepositoryImpl() }
    }

    var todosRepository: Factory<TodosRepository> {
        Factory(self) { TodosRepositoryImpl() }
    }

    @MainActor
    var modelContext: Factory<ModelContext?> {
        Factory(self) {
            return (try? ModelContainer(for: TodoItem.self))?.mainContext
        }
    }
}
