//
//  OrderView.swift
//  Toucheese
//
//  Created by 최주리 on 12/6/24.
//

import SwiftUI

import Combine

struct OrderView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    private let orderService = DefaultOrderService()
    @State private var bag = Set<AnyCancellable>()
    
    @State private var selectedPayment: PaymentType = .pg
    @State private var isSuccessOrder: Bool = false
    @State private var user: UserEntity = .init(
        name: "-",
        phone: "-",
        email: "-"
    )
    
    let studio: StudioInfo
    let product: StudioProduct
    let totalPrice: Int
    let selectedDate: Date
    
    private var selectedOptions: [StudioProductOption] {
        product.optionList.filter { $0.count > 0 }
    }
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("주문 확인")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.bottom, -24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("주문자 정보")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.vertical, 14)
                        //TODO: API 받으면 고치기
                        OrderUserInformationView(user: user)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Rectangle()
                            .frame(height: 8)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.gray02)
                            .padding(.horizontal, -16)
                        Text("예약 정보")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.vertical, 14)
                        
                        OrderStudioInformationView(
                            studioName: studio.name,
                            selectedDateString: selectedDate.getDateString()
                        )
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Rectangle()
                            .frame(height: 8)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.gray02)
                            .padding(.horizontal, -16)
                        Text("주문 상품")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.vertical, 14)
                        
                        OrderProductInformationView(
                            product: product,
                            studioName: studio.name,
                            selectedOptions: selectedOptions,
                            totalPrice: totalPrice
                        )
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Rectangle()
                            .frame(height: 8)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.gray02)
                            .padding(.horizontal, -16)
                        Text("결제수단")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.vertical, 14)
                        ForEach(PaymentType.allCases, id: \.self) { type in
                            PaymentRadioButton(type: type, selectedType: $selectedPayment)
                            .padding(.vertical, 10)
                        }
                    }
         
                    VStack(alignment: .leading, spacing: 0) {
                        Rectangle()
                            .frame(height: 8)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.gray02)
                            .padding(.horizontal, -16)
                        Text("결제 정보")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.vertical, 14)
                        HStack {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("주문 금액")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.gray06)
                                Text("총 결제 금액")
                                    .font(.system(size: 16, weight: .bold))
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 16) {
                                Text("\(totalPrice)원")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.gray06)
                                Text("\(totalPrice)원")
                                    .font(.system(size: 16, weight: .bold))
                            }
                        }
                    }
                
                    Button {
                        createOrder()
                    } label: {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.primary06)
                            .frame(height: 48)
                            .overlay {
                                Text("\(totalPrice)원 결제하기")
                                    .font(.system(size: 16, weight: .bold))
                            }
                    }
                    .buttonStyle(.plain)
                    .padding(.vertical, 8)
                    .padding(.top, 21)
                    
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            .foregroundStyle(.gray09)
            .navigationTitle("주문/결제")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
    }
    
    private func createOrder() {
        
        var newOptionList: [OptionRequestEntity] = []
        for option in selectedOptions {
            let newOption = OptionRequestEntity(optionId: option.id, optionQuantity: 1)
            newOptionList.append(newOption)
        }
        
        let item = ItemRequestEntity(itemId: product.id, itemQuantity: 1, orderRequestOptionDtos: newOptionList)
        let newOrder = OrderEntity(
            name: user.name,
            email: user.email,
            phone: user.phone,
            studioId: studio.id,
            orderDateTime: selectedDate.getISODateString(),
            orderRequestItemDtos: [item]
        )
        
        orderService.createOrder(order: newOrder)
            .sink { event in
                switch event {
                case .finished:
                    print("Success: \(event)")
                case .failure(let error):
                    print(error.localizedDescription)
                    navigationManager.toast = .orderFail
                }
            } receiveValue: { result in
                if result {
                    navigationManager.push(
                        .orderSuccessView(
                            studio: studio,
                            product: product,
                            totalPrice: totalPrice,
                            selectedDate: selectedDate.getDateString(),
                            selectedOptions: selectedOptions
                        )
                    )
                } else {
                    navigationManager.toast = .orderFail
                }
            }
            .store(in: &bag)
    }
}

#Preview {
    OrderView(studio: .init(id: 0, name: "공원스튜디오", profileImage: "", backgrounds: [], popularity: 0, dutyDate: "", address: "", description: ""), product: .init(id: 0, image: "", name: "증명사진", description: "", reviewCount: 0, price: 75000, optionList: [.init(id: 0, name: "보정사진 추가", description: "", price: 30000, count: 1)]), totalPrice: 105000, selectedDate: Date())
}
