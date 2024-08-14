//
//  Screen.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 24/04/2024.
//

import SwiftUI
import Defaults
import RswiftResources

struct Screen<Content>: View where Content: View {
    @Binding private var isLoading: Bool
    @State private var language = Defaults[.language]
    @Default(.isDarkMode) var isDarkMode
    private var title: String?

    var content: () -> Content

    init(isLoading: Binding<Bool> = .constant(false),
         title: String? = nil,
         content: @escaping () -> Content) {
        _isLoading = isLoading
        self.title = title
        self.content = content
    }

    var body: some View {
        LoadingView(isShowing: $isLoading) {
            content()
        }
        .navigationTitle(title ?? "")
        .background(Color(R.color.backgroundPrimary))
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .onAppear {
            Task {
                for await value in Defaults.updates(.language) {
                    language = value
                }
            }
        }
    }
}
