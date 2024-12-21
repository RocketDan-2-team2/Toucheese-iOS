//
//  SignUpEmailView.swift
//  Toucheese
//
//  Created by 유지호 on 12/21/24.
//

import SwiftUI

struct SignUpEmailView: View {
    @FocusState private var isFocused: Bool
    @State private var fieldState: InputFieldState = .empty
    @State private var email: String = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("이메일을 입력해주세요.")
                    .font(.system(size: 24, weight: .semibold))
                    .lineSpacing(1.4)
                    .frame(height: 34)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            
            InputField(
                title: "이메일",
                placeholder: "이메일을 입력해주세요",
                fieldState: $fieldState,
                inputField: $email
            )
            .focused($isFocused)
            .padding(.bottom, 36)
            
            Spacer()
            
            Button {
                validateEmail()
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.yellow)
                    .frame(height: 48)
                    .overlay {
                        Text("다음으로")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.gray09)
                    }
            }
        }
        .padding()
        .background {
            Color.white
                .onTapGesture {
                    isFocused = false
                }
        }
    }

    func validateEmail() {
        if email.isEmpty {
            fieldState = .error(message: "이메일을 입력해주세요.")
        } else if !email.isValidEmail() {
            fieldState = .error(message: "정확한 이메일을 입력해주세요.")
        } else {
            // API 호출
            isFocused = false
        }
    }
}

#Preview {
    SignUpEmailView()
}
