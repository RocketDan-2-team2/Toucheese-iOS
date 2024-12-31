//
//  SignUpNicknameView.swift
//  Toucheese
//
//  Created by 유지호 on 12/20/24.
//

import SwiftUI
import Combine

struct SignUpNicknameView: View {
    let authService: AuthService = DefaultAuthService()
    
    @EnvironmentObject private var navigationManager: AuthNavigationManager
    
    @FocusState private var isFocused: Bool
    @State private var fieldState: InputFieldState = .empty
    @State private var nickname: String = ""
    
    @State private var bag = Set<AnyCancellable>()
    
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
                placeholder: "국문, 영문 혼합 불가, 숫자 또는 특수문자 불가",
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
            // 국문일 때
            if nickname.isValidKoreanNickname() {
                if nickname.count > 7 {
                    fieldState = .error(message: "국문은 최대 7자까지 입력 가능합니다.")
                } else {
                    fieldState = .error(message: "자음 또는 모음, 특수문자를 사용할 수 없습니다.")
                }
            }
            // 영문일 때
            else if nickname.isValidEnglishNickname() {
                if nickname.count > 14 {
                    fieldState = .error(message: "영문은 최대 14자까지 입력 가능합니다.")
                }
            }
            // 국문만 또는 영문만으로 구성되어 있지 않을 때
            else {
                fieldState = .error(message: "국문과 영문, 특수기호를 함께 사용할 수 없습니다.")
            }
        } else {
            // API 호출
            isFocused = false
            checkNickname()
        }
    }
    
    func checkNickname() {
        authService.nicknameCheck(nickname)
            .sink { event in
                print("SignUpNickname: \(event)")
            } receiveValue: { isDuplicated in
                if isDuplicated {
                    fieldState = .error(message: "중복된 닉네임입니다.")
                } else {
                    updateUserProfile()
                }
            }
            .store(in: &bag)
    }
    
    func updateUserProfile() {
        authService.profileUpdate(name: nil, nickname: nickname, email: nil, phone: nil)
        .sink { event in
            print("SignUpNickname: \(event)")
        } receiveValue: { isSuccessed in
            if !isSuccessed { return }
            navigationManager.push(.complete)
        }
        .store(in: &bag)
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
    .environmentObject(AuthNavigationManager())
}
