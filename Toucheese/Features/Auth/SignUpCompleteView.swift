//
//  SignUpCompleteView.swift
//  Toucheese
//
//  Created by 유지호 on 12/21/24.
//

import SwiftUI

struct SignUpCompleteView: View {
    @EnvironmentObject private var navigationManager: AuthNavigationManager

    @State private var showContent: Bool = false
    @State private var showButton: Bool = false
    
    let nickname: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(.completeLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .opacity(showContent ? 1 : 0)
                .animation(.smooth(duration: 1), value: showContent)
            
            VStack {
                Text("\(nickname)님,\n가입을 축하드려요!")
                    .font(.system(size: 24, weight: .semibold))
                    .frame(height: 68)
                    .opacity(showContent ? 1 : 0)
                    .animation(.smooth(duration: 1).delay(0.75), value: showContent)
                
                Text("터치즈에서 스튜디오를 둘러보고,\n예약까지 간편하게 즐겨보세요.")
                    .font(.system(size: 16, weight: .regular))
                    .frame(height: 44)
                    .opacity(showContent ? 1 : 0)
                    .animation(.smooth(duration: 1).delay(1.5), value: showContent)
            }
            .lineSpacing(1.4)
            .multilineTextAlignment(.center)
            .padding(.bottom)
            
            if showButton {
                Button {
                    UserDefaultsKey.Auth.isLogined = true
                    navigationManager.popToRoot()
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.yellow)
                        .frame(height: 48)
                        .overlay {
                            Text("스튜디오 둘러보기")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.gray09)
                        }
                }
                .padding(.bottom, 100)
            }
        }
        .padding()
        .toolbar(.hidden, for: .navigationBar)
        .animation(.smooth(duration: 2).delay(2.25), value: showButton)
        .onAppear {
            showContent = true
            showButton = true
        }
    }
}

#Preview {
    SignUpCompleteView(nickname: "지존지호")
        .environmentObject(AuthNavigationManager())
}
