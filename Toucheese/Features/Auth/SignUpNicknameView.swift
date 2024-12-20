//
//  SignUpNicknameView.swift
//  Toucheese
//
//  Created by 유지호 on 12/20/24.
//

import SwiftUI

struct SignUpNicknameView: View {
    @State private var fieldState: InputFieldState = .empty
    @State private var nickname: String = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("터치즈에서\n사용하실 닉네임을 알려주세요!")
                    .font(.system(size: 24, weight: .semibold))
                    .lineSpacing(1.4)
                    .frame(height: 68)
                
                Text("국문 최대 7자, 영문 최대 14자까지 가능해요.")
                    .font(.system(size: 16))
                    .foregroundStyle(.gray06)
                    .frame(height: 22)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            
            InputField(
                title: "닉네임",
                placeholder: "닉네임을 입력해주세요",
                fieldState: $fieldState,
                inputField: $nickname
            )
            .padding(.bottom, 36)
            
            Button {
                fieldState = .error(message: "잘못된 필드")
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
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        SignUpNicknameView()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
    }
}
