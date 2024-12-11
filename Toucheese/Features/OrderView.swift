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
    let selectedOptions: [StudioProductOption]
    let totalPrice: Int
    let selectedDate: Date
    let user: UserEntity = .init(
        name: "강미미",
        phone: "010-1234-5678",
        email: "toucheeseeni@gmail.com"
    )
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("내 정보")
                    .fontWeight(.bold)
                    .padding(.vertical, 5)
                HStack {
                    VStack(alignment: .leading) {
                        Text("성함")
                        Text("연락처")
                        Text("이메일")
                    }
                    VStack(alignment: .leading) {
                        Text("\(user.name)")
                        Text("\(user.phone)")
                        Text("\(user.email)")
                            .tint(.black)
                    }
                    .padding(.leading, 50)
                }
            }
            .padding(.vertical)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("상품 확인")
                    .fontWeight(.bold)
                    .padding(.vertical, 5)
                HStack {
                    AsyncImage(url: URL(string: product.image ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    } placeholder: {
                        //TODO: 스켈레톤 처리하기
                        ProgressView()
                    }
                    VStack(alignment: .leading) {
                        Text("\(studio.name)")
                            .fontWeight(.bold)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(product.name)")
                                ForEach(selectedOptions) { option in
                                    Text(option.name)
                                }
                                
                                Text("예약 날짜")
                            }
                            VStack(alignment: .trailing) {
                                Text("\(product.price)원")
                                ForEach(selectedOptions) { option in
                                    Text("\(option.price)원")
                                }
                                Text("\(selectedDate)")
                                    .lineLimit(1)
                            }
                        }
                    }
                }
            }
            .padding(.vertical)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("결제수단")
                    .fontWeight(.bold)
                    .padding(.vertical, 5)
                ForEach(PaymentType.allCases, id: \.self) { type in
                    PaymentRadioButton(type: type, selectedType: $selectedPayment) {
                        
                    }
                        .padding(.vertical, 1)
                }
            }
            .padding(.vertical)
            
            Spacer()
            
            Button {
                //TODO: 실패했을 때는?? 아직 생각 안 해봄
                createOrder()
            } label: {
                Capsule()
                    .fill(.yellow)
                    .frame(height: 40)
                    .overlay {
                        Text("결제하기 (₩\(totalPrice))")
                            .fontWeight(.bold)
                    }
            }
            .buttonStyle(.plain)
        }
        .padding()
        .navigationTitle("주문/결제")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .navigationDestination(isPresented: $isSuccessOrder, destination: {
            OrderSuccessView()
        })
    }
    
    private func createOrder() {
        
        //TODO: 재웅님이 어떻게 넘겨주냐에 따라 달라질 듯 !
        guard let timeZone = TimeZone(abbreviation: "KST") else { return }
        let dateString = ISO8601DateFormatter.string(from: selectedDate, timeZone: timeZone, formatOptions: [.withFullDate, .withTime, .withColonSeparatorInTime])
        
        var newOptionList: [OptionDTO] = []
        for option in selectedOptions {
            let newOption = OptionDTO(optionId: option.id, optionQuantity: 1)
            newOptionList.append(newOption)
        }
        
        let item = ItemDTO(itemId: product.id, itemQuantity: 1, orderRequestOptionDtos: newOptionList)
        let newOrder = OrderEntity(
            name: "\(user.name)",
            email: "\(user.email)",
            phone: "\(user.phone)",
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
            } receiveValue: { val in
                isSuccessOrder = val
            }
            .store(in: &bag)
    }
}
