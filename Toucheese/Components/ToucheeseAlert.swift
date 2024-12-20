//
//  ToucheeseAlert.swift
//  Toucheese
//
//  Created by 최주리 on 12/19/24.
//

import SwiftUI

struct ToucheeseAlertModifier: ViewModifier {
    
    @Binding var alert: AlertType?
    
    func body(content: Content) -> some View {
        ZStack {
            content

            if alert != nil {
                ToucheeseAlert(alert: $alert)
            }
        }

    }
}

struct ToucheeseAlert: View {
    
    @Binding var alert: AlertType?
    
    var date: String?
    
    var body: some View {
        ZStack {
            Color.gray10.opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text(description)
                    .font(.system(size: 16, weight: .medium))
                    .multilineTextAlignment(.center)
                    .padding(.top, 32)
                    .padding(.bottom, 8)
                
                HStack(spacing: 0) {
                    Button(action: {
                        if let confirmAction {
                            confirmAction()
                        }
                        alert = nil
                    }, label: {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.primary06)
                            .frame(height: 48)
                            .overlay {
                                Text(confirmText)
                                    .font(.system(size: 16, weight: .bold))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                            }
                    })
                    
                    if isCancelButton {
                        Button(action: {
                            alert = nil
                        }, label: {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.gray02)
                                .frame(height: 48)
                                .overlay {
                                    Text(cancelText)
                                        .font(.system(size: 16, weight: .bold))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.black)
                                }
                        })
                    }
                }
                .padding(16)
            }
            .background(.gray01, in: RoundedRectangle(cornerRadius: 24))
            .padding(.horizontal, 16)
        }
        .background(.clear)
    }
}

extension ToucheeseAlert {
    var description: String {
        switch alert {
        case let .dateChanged(date):
            "\(date)로\n예약일정이 변경되었습니다."
        case .reservationCancel:
            "예약을 정말 취소하시겠습니까?"
        default:
            ""
        }
    }
    
    var confirmAction: (() -> Void)? {
        switch alert {
        case .dateChanged:
            nil
        case let .reservationCancel(action):
            action
        case .none:
            nil
        }
    }
    
    var confirmText: String {
        switch alert {
        case .dateChanged:
            "확인"
        case .reservationCancel:
            "예"
        case .none:
            ""
        }
    }
    var cancelText: String {
        switch alert {
        case .dateChanged, .reservationCancel: "아니오"
        case .none: ""
        }
    }
    
    var isCancelButton: Bool {
        switch alert {
        case .dateChanged: false
        case .reservationCancel: true
        case .none: false
        }
    }
}

extension View {
  
    func toucheeseAlert(
        alert: Binding<AlertType?>
    )
    -> some View {
        modifier(
            ToucheeseAlertModifier(alert: alert)
        )
    }
}
