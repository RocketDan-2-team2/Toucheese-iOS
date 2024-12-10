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
    
    let studio: StudioInfo
    let product: StudioProduct
    let selectedOptions: [StudioProductOption]
    let totalPrice: Int
    let selectedDate: Date
    
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
                    //TODO: 임시
                    VStack(alignment: .leading) {
                        Text("강미미")
                        Text("010-1111-1111")
                        Text("kang@hanmail.net")
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
                                Text("\(totalPrice)원")
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
    }
    
    private func createOrder() {
        
        var newOptionList: [OptionDTO] = []
        for option in selectedOptions {
            let newOption = OptionDTO(optionId: option.id, optionQuantity: 1)
            newOptionList.append(newOption)
        }
        
        let item = ItemDTO(itemId: product.id, itemQuantity: 1, optionDtoList: newOptionList)
        
        let newOrder = OrderEntity(
            name: "강미미",
            email: "kang@hanmail.net",
            phone: "010-1111-1111",
            studioID: studio.id,
            orderDateTime: selectedDate,
            itemDto: [item]
        )
        
        orderService.createOrder(order: newOrder)
            .sink { event in
                switch event {
                case .finished:
                    print("Success: \(event)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { _ in
                //TODO: 성공이면 뷰 전환하기
            }
            .store(in: &bag)
    }
}
