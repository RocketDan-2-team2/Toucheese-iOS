//
//  ToucheeseToast.swift
//  Toucheese
//
//  Created by 최주리 on 12/23/24.
//

import SwiftUI

struct ToucheeseToastModifier: ViewModifier {
    
    @Binding var toast: ToastType?
    @State private var yOffset = 200
    @State private var opacity: Double = 0
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content

            if toast != nil {
                ToucheeseToast(toast: $toast)
                    .opacity(opacity)
                    .offset(y: CGFloat(yOffset))
                    .onAppear {
                        withAnimation(.bouncy) {
                            yOffset = 0
                        }
                        withAnimation(.easeIn) {
                            opacity = 1
                        }
                        dismissAfterShow()
                    }
            }
        }
    }
    
    func dismissAfterShow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.bouncy.speed(0.8), {
                yOffset = 200
                opacity = 0
            }, completion: {
                toast = nil
            })
        }
    }
}

struct ToucheeseToast: View {
    
    @Binding var toast: ToastType?
    
    var body: some View {
        HStack {
            Text(description)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.white)
            Spacer()
        }
        .padding(EdgeInsets(top: 11.5, leading: 16, bottom: 11.5, trailing: 16))
        .background(.gray09, in: RoundedRectangle(cornerRadius: 8))
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
    }
}

extension ToucheeseToast {
    private var description: String {
        switch toast {
        case let .cancelSuccess(date):
            "[\(date)]예약이 취소되었습니다."
        case .cancelFail:
            "예약 취소에 실패하였습니다. 다시 시도해주세요."
        case .orderFail:
            "예약에 실패하였습니다. 다시 시도해주세요."
        case .reservationUpdateFail:
            "예약 변경에 실패하였습니다. 다시 시도해주세요."
        case nil:
            "알 수 없는 오류입니다. 다시 시도해주세요."
        }
    }
}

#Preview {
    ToucheeseToast(toast: .constant(.cancelFail))
}
