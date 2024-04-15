//
//  BaseButton.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 25/04/2024.
//

import SwiftUI

struct BaseButton: View {
    var title: String
    var isEnabled = true
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(isEnabled ? .white : Color.white.opacity(0.5))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .foregroundStyle(.white)
        .background(Color(R.color.primary))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .disabled(!isEnabled)
    }
}
