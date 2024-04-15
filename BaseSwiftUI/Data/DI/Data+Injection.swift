//
//  Data+Injection.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 19/04/2024.
//

import Factory
import FirebaseAuth

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
}
