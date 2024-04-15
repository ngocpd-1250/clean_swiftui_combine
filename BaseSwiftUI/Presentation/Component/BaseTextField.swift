//
//  BaseTextField.swift
//  BaseSwiftUI
//
//  Created by phan.duong.ngoc on 16/04/2024.
//

import SwiftUI

struct BaseTextField: View {
    @Binding var text: String

    private let placeholder: String
    private let image: Image
    private var isSecure = false
    private var errorMessage = ""

    init(text: Binding<String>, placeholder: String, image: Image, isSecure: Bool = false, errorMessage: String = "") {
        _text = text
        self.placeholder = placeholder
        self.image = image
        self.isSecure = isSecure
        self.errorMessage = errorMessage
    }

    var body: some View {
        VStack {
            HStack {
                image
                    .foregroundColor(.gray)
                    .padding(.leading, Spacing.small.value)
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .padding(Spacing.small.value)
                        .font(.subheadline)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .tint(Color(R.color.labelPrimary))
                        .foregroundStyle(Color(R.color.labelPrimary))
                } else {
                    TextField(placeholder, text: $text)
                        .padding(Spacing.small.value)
                        .font(.subheadline)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .tint(Color(R.color.labelPrimary))
                        .foregroundStyle(Color(R.color.labelPrimary))
                }
            }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(R.color.separatorPrimary))
                .padding(.trailing, Spacing.small.value)

            if !errorMessage.isEmpty {
                withAnimation {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
