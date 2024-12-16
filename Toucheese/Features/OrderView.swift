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
    
    @State private var isShowAlert = false
    
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
    
    private var selectedDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일(E) a h시"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: selectedDate)
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
                            .foregroundStyle(.gray07)
                            .padding(.leading, 30)
                        }
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
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(studio.name)")
                                .font(.system(size: 16, weight: .bold))
                            Text(selectedDateString)
                                .font(.system(size: 16, weight: .medium))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(.gray01, in: RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray02)
                        }
                        
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
                                HStack(alignment: .center, spacing: 2) {
                                    Image(.homeFilled)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 12, height: 12)
                                    Text("\(studio.name)")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundStyle(.gray06)
                                }
                                .padding(.bottom, 8)
                                HStack {
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("\(product.name)")
                                            .font(.system(size: 14, weight: .semibold))
                                            .padding(.bottom, 6)
                                        ForEach(selectedOptions) { option in
                                            HStack(alignment: .center, spacing: 2) {
                                                Image(.turnRight)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 16, height: 16)
                                                Text("\(option.name)")
                                                    .font(.system(size: 12, weight: .regular))
                                                    .foregroundStyle(.gray06)
                                            }
                                            .padding(.bottom, 4)
                                        }
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        Text("\(product.price)원")
                                            .font(.system(size: 14, weight: .semibold))
                                            .padding(.bottom, 6)
                                        ForEach(selectedOptions) { option in
                                            Text("+\(option.price)원")
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundStyle(.gray06)
                                                .padding(.bottom, 4)
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
                        .background(.gray01, in: RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray02)
                        }
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
        //TODO: 임시
            .alert("결제 요청이 실패했습니다.", isPresented: $isShowAlert) {
                Button("확인") {
                    
                }
            } message: {
                Text("다시 시도해주세요.")
            }
    }
    
    private func createOrder() {
        
        guard let timeZone = TimeZone(abbreviation: "KST") else { return }
        let dateString = ISO8601DateFormatter.string(from: selectedDate,
                                                     timeZone: timeZone,
                                                     formatOptions: [.withFullDate, .withTime, .withColonSeparatorInTime])
        
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
                    isShowAlert = true
                }
            } receiveValue: { result in
                isSuccessOrder = result
                
                if isSuccessOrder {
                    navigationManager.push(
                        .orderSuccessView(
                            studio: studio,
                            product: product,
                            totalPrice: totalPrice,
                            selectedDate: selectedDateString,
                            selectedOptions: selectedOptions
                        )
                    )
                } else {
                    isShowAlert = true
                }
            }
            .store(in: &bag)
    }
}

#Preview {
    OrderView(studio: .init(id: 0, name: "공원스튜디오", profileImage: "", backgrounds: [], popularity: 0, dutyDate: "", address: "", description: ""), product: .init(id: 0, image: "", name: "증명사진", description: "", reviewCount: 0, price: 75000, optionList: [.init(id: 0, name: "보정사진 추가", description: "", price: 30000, count: 1)]), totalPrice: 105000, selectedDate: Date())
}
