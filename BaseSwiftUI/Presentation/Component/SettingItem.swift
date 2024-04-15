//
//  SettingItem.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 24/04/2024.
//

import SwiftUI

struct SettingItem: View {
    let title: String
    var value: Bool?
    let action: () -> Void

    var body: some View {
        HStack {
            if let value = value {
                Text(title)
                    .fontWeight(.medium)
                    .foregroundStyle(Color(R.color.labelPrimary))
                Spacer()
                Toggle(isOn: Binding<Bool>(
                    get: { value },
                    set: { _ in action() }
                )) {
                    EmptyView()
                }
                .labelsHidden()
                .tint(Color(R.color.primary))
            } else {
                Button(action: action) {
                    HStack {
                        Text(title)
                            .fontWeight(.medium)
                            .foregroundStyle(Color(R.color.labelPrimary))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}
