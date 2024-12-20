//
//  LoginView.swift
//  Toucheese
//
//  Created by 유지호 on 12/19/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                Image(.toucheeseIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Text("TOUCHEESE")
                    .font(.system(size: 30, weight: .heavy))
                    .foregroundStyle(.primary06)
                    .frame(height: 30)
            }
            
            VStack {
                Text("터치즈에서 딱 맞는\n스튜디오를 찾아보세요!")
                    .font(.system(size: 24, weight: .semibold))
                    .lineSpacing(1.4)
                    .multilineTextAlignment(.center)
                    .frame(height: 68)
                
                Text("컨셉별 스튜디오를 확인 후 예약까지 간편하게!")
                    .font(.system(size: 16))
                    .frame(height: 22)
            }
            
            VStack {
                SocialLoginButton(.kakao) {
                    
                }
                
                SocialLoginButton(.google) {
                    
                }
                
                SocialLoginButton(.apple) {
                    
                }
            }
            .padding(.top, 86)
        }
        .padding(.horizontal)
    }
}

#Preview {
    LoginView()
}
