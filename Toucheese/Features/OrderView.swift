//
//  OrderView.swift
//  Toucheese
//
//  Created by 최주리 on 12/6/24.
//

import SwiftUI

import Combine

struct OrderView: View {
    
    private let orderService = DefaultOrderService()
    @State private var bag = Set<AnyCancellable>()
    
    @State private var selectedPayment: PaymentType = .pg
    @State private var isSuccessOrder: Bool = false
    
    let studio: StudioInfo
    let product: StudioProduct
    let totalPrice: Int
    let selectedDate: Date
    let user: UserEntity = .init(
        name: "강미미",
        phone: "010-1234-5678",
        email: "toucheeseeni@gmail.com"
    )
    
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
                            .padding(.leading, 30)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Rectangle()
                            .frame(height: 8)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.gray)
                            .padding(.horizontal, -16)
                        Text("예약 정보")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.vertical, 14)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(studio.name)")
                                .font(.system(size: 16, weight: .bold))
                            //TODO: 날짜 어떻게 넘어오는지 확인하고 고치기
                            Text("12월 24일(화) 오후 02:00")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.gray, in: RoundedRectangle(cornerRadius: 8))
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Rectangle()
                            .frame(height: 8)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.gray)
                            .padding(.horizontal, -16)
                        Text("주문 상품")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.vertical, 14)
                        HStack {
                            AsyncImage(url: URL(string: product.image ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 52, height: 68)
                            } placeholder: {
                                //TODO: 스켈레톤 처리하기
                                ProgressView()
                            }
                            VStack(alignment: .leading, spacing: 0) {
                                Text("\(studio.name)")
                                    .font(.system(size: 12, weight: .medium))
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(product.name)")
                                            .font(.system(size: 14, weight: .semibold))
                                        ForEach(selectedOptions) { option in
                                            Text("-\(option.name)")
                                                .font(.system(size: 12, weight: .regular))
                                        }
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        Text("\(product.price)원")
                                            .font(.system(size: 14, weight: .semibold))
                                        ForEach(selectedOptions) { option in
                                            Text("+\(option.price)원")
                                                .font(.system(size: 12, weight: .regular))
                                        }
                                    }
                                }
                                HStack {
                                    Spacer()
                                    Text("총 \(totalPrice)원")
                                        .font(.system(size: 16, weight: .bold))
                                        .padding(.top, 8)
                                }
                            }
                            .padding(.leading, 16)
                        }
                        .padding()
                        .background(.gray, in: RoundedRectangle(cornerRadius: 8))
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Rectangle()
                            .frame(height: 8)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.gray)
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
                            .foregroundStyle(.gray)
                            .padding(.horizontal, -16)
                        Text("결제 정보")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.vertical, 14)
                        HStack {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("주문 금액")
                                    .font(.system(size: 14, weight: .medium))
                                Text("총 결제 금액")
                                    .font(.system(size: 16, weight: .bold))
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 16) {
                                Text("\(totalPrice)원")
                                    .font(.system(size: 14, weight: .medium))
                                Text("\(totalPrice)원")
                                    .font(.system(size: 16, weight: .bold))
                            }
                        }
                    }
                
                    Button {
                        //TODO: 실패했을 때는?? 아직 생각 안 해봄
                        createOrder()
                    } label: {
                        Capsule()
                            .fill(.yellow)
                            .frame(height: 40)
                            .overlay {
                                Text("결제하기 (₩\(totalPrice))")
                                    .font(.system(size: 16, weight: .bold))
                            }
                    }
                    .buttonStyle(.plain)
                    .padding(.vertical, 8)
                    .padding(.top, 21)
                    
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .navigationTitle("주문/결제")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarRole(.editor)
                .navigationDestination(isPresented: $isSuccessOrder, destination: {
                    OrderSuccessView()
                })
            }
    }
    
    private func createOrder() {
        
        //TODO: 재웅님이 어떻게 넘겨주냐에 따라 달라질 듯 !
        guard let timeZone = TimeZone(abbreviation: "KST") else { return }
        let dateString = ISO8601DateFormatter.string(from: selectedDate, timeZone: timeZone, formatOptions: [.withFullDate, .withTime, .withColonSeparatorInTime])
        
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
            orderDateTime: dateString,
            orderRequestItemDtos: [item]
        )
        
        orderService.createOrder(order: newOrder)
            .sink { event in
                switch event {
                case .finished:
                    print("Success: \(event)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { result in
                isSuccessOrder = result
            }
            .store(in: &bag)
    }
}

#Preview {
    OrderView(studio: .init(id: 0, name: "공원스튜디오", profileImage: "", backgrounds: [], popularity: 0, dutyDate: "", address: "", description: ""), product: .init(id: 0, image: "", name: "증명사진", description: "", reviewCount: 0, price: 75000, optionList: [.init(id: 0, name: "보정사진 추가", description: "", price: 30000, count: 1)]), totalPrice: 105000, selectedDate: Date())
}
