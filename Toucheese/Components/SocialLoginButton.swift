//
//  SocialLoginButton.swift
//  Toucheese
//
//  Created by 유지호 on 12/20/24.
//

import SwiftUI

struct SocialLoginButton: View {    
    let socialType: SocialType
    let buttonAction: () -> Void
    
    var background: Color {
        switch socialType {
        case .kakao: .kakaoYellow
        case .google: .white
        case .apple: .gray09
        }
    }
    
    init(_ socialType: SocialType, buttonAction: @escaping () -> Void) {
        self.socialType = socialType
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            RoundedRectangle(cornerRadius: 8)
                .fill(background)
                .strokeBorder(socialType == .google ? .gray : .clear)
                .frame(height: 56)
                .overlay {
                    HStack {
                        Image(socialType.logo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                        
                        Text("\(socialType.title)로 로그인")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .foregroundStyle(socialType == .apple ? .white : .gray09)
                }
        }
    }
}
