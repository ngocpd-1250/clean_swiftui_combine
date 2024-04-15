//
//  TodosScreen.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 22/04/2024.
//

import SwiftUI
import Defaults

struct TodosScreen: View {
    private let navigator: HomeRootNavigatorType

    init(navigator: HomeRootNavigatorType) {
        self.navigator = navigator
    }

    var body: some View {
        Screen {
            VStack {
                Text("Comming Soon")
                    .foregroundStyle(Color(R.color.labelPrimary))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
