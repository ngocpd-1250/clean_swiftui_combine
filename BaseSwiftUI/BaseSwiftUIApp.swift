//
//  BaseSwiftUIApp.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 15/04/2024.
//

import SwiftUI
import LinkNavigator
import Firebase
import Defaults
import Then

@main
struct BaseSwiftUIApp: App {
    init() {
        FirebaseApp.configure()
        Appearance.configure()
    }

    var body: some Scene {
        MainApp()
    }
}
