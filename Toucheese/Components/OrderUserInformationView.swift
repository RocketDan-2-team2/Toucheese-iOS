//
//  OrderUserInformationView.swift
//  Toucheese
//
//  Created by 최주리 on 12/18/24.
//

import SwiftUI

struct OrderUserInformationView: View {
    
    let user: UserEntity
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("성함")
                Text("연락처")
                Text("이메일")
            }
            .font(.system(size: 14, weight: .medium))
            VStack(alignment: .leading, spacing: 10) {
                Text(user.name)
                Text(user.phone)
                Text(user.email)
                    .tint(.black)
            }
            .font(.system(size: 14, weight: .regular))
            .foregroundStyle(.gray07)
            .padding(.leading, 30)
        }
    }
}
