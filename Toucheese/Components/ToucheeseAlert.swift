//
//  ToucheeseAlert.swift
//  Toucheese
//
//  Created by 최주리 on 12/19/24.
//

import SwiftUI

struct ToucheeseAlertModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    let alert: ToucheeseAlert
    
    func body(content: Content) -> some View {
        content
            .clearFullScreenCover(isPresented: $isPresented) {
                alert
            }
            .transaction { transaction in
                transaction.disablesAnimations = true
            }
    }
}

struct ToucheeseAlert: View {
    
    let type: AlertType
    @Binding var isPresented: Bool
    
    var changeDate: String?
    var confirmAction: (() -> Void)?
    
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
                        isPresented = false
                        guard let confirmAction else { return }
                        confirmAction()
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
                            isPresented = false
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
        switch type {
        case .dateChanged:
            "\(changeDate ?? "")로\n예약일정이 변경되었습니다."
        case .reservationCancel:
            "예약을 정말 취소하시겠습니까?"
        }
    }
    
    var confirmText: String {
        switch type {
        case .dateChanged:
            "확인"
        case .reservationCancel:
            "예"
        }
    }
    var cancelText: String {
        switch type {
        case .dateChanged, .reservationCancel: "아니오"
        }
    }
    
    var isCancelButton: Bool {
        switch type {
        case .dateChanged: false
        case .reservationCancel: true
        }
    }
}

extension View {
    /// 투명 fullScreenCover
    func clearFullScreenCover<Content: View>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View {
        fullScreenCover(isPresented: isPresented) {
            ZStack {
                content()
            }
            .background(ClearBackground())
        }
    }
    
    func toucheeseAlert(
        isPresented: Binding<Bool>,
        alert: @escaping() -> ToucheeseAlert)
    -> some View {
        modifier(
            ToucheeseAlertModifier(isPresented: isPresented, alert: alert())
        )
    }
}

struct ClearBackground: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = ClearBackgroundView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

/// 깜빡거리는 현상 해결
final class ClearBackgroundView: UIView {
    override func layoutSubviews() {
        guard let parentView = superview?.superview else { return }
        parentView.backgroundColor = .clear
    }
}
