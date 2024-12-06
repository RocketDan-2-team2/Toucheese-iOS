//
//  OrderSuccessView.swift
//  Toucheese
//
//  Created by 최주리 on 12/6/24.
//

import SwiftUI

struct OrderSuccessView: View {
    var body: some View {
        VStack {
        
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 50))
                .foregroundStyle(.yellow)
                .padding(50)
            Text("예약이 접수되었습니다.")
                .font(.system(size: 22, weight: .bold))

            Spacer()
            
            Button(action: {
                
            }, label: {
                Capsule()
                    .fill(.yellow)
                    .frame(width: 180, height: 40)
                    .overlay {
                        Text("계속 둘러보기")
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
            })
            .padding(.bottom, 80)
        }
    }
}

#Preview {
    OrderSuccessView()
}

