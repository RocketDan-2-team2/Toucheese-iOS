//
//  SignUpNicknameView.swift
//  Toucheese
//
//  Created by 유지호 on 12/20/24.
//

import SwiftUI

struct SignUpNicknameView: View {
    @FocusState private var isFocused: Bool
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
                placeholder: "닉네임을 입력해주세요 (국문, 영문 혼합 불가)",
                fieldState: $fieldState,
                inputField: $nickname
            )
            .focused($isFocused)
            .padding(.bottom, 36)
            
            Spacer()
            
            Button {
                validateNickname()
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
    
    func validateNickname() {
        if nickname.isEmpty {
            fieldState = .error(message: "닉네임을 입력해주세요")
        } else if !nickname.isValidNickname() {
            if nickname.isValidKoreanNickname() {
                if nickname.count > 7 {
                    fieldState = .error(message: "국문은 최대 7자까지 입력 가능합니다.")
                } else {
                    fieldState = .error(message: "자음 또는 모음만 사용할 수 없습니다.")
                }
            } else if nickname.isValidEnglishNickname() {
                if nickname.count > 14 {
                    fieldState = .error(message: "영문은 최대 14자까지 입력 가능합니다.")
                }
            } else {
                fieldState = .error(message: "국문과 영문을 함께 사용할 수 없습니다.")
            }
        } else {
            // API 호출
            isFocused = false
        }
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
