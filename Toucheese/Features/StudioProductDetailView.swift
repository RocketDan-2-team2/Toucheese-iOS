//
//  StudioProductDetailView.swift
//  Toucheese
//
//  Created by 유지호 on 11/29/24.
//

import SwiftUI

struct StudioProductDetailView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let studio: StudioInfo
    @State private var product: StudioProduct
    
    // MARK: 캘린더 API에 따라 달라질 예정. 현재 임시 값
    @State private var selectedDate: Date = .now
    @State private var selectedTime: Int = 1
    // ========================================
    
    @State private var showCalendar: Bool = false
    
    private var calculatedDateNTime: String {
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        let tempDate = df.string(from: selectedDate)
        let tempAMPM = selectedTime > 11 ? "PM" : "AM"
        let tempTime = selectedTime > 12 ? selectedTime - 12 : selectedTime
        
        let result = tempDate + " \(tempAMPM) \(tempTime):00"
        
        return result
    }
    
    var totalPrice: Int {
        product.optionList.reduce(product.price) {
            $0 + $1.price * $1.count
        }
    }
    
    let studioService: StudioService = DefaultStudioService()

    init(studio: StudioInfo, product: StudioProduct) {
        self.studio = studio
        self.product = product
        self.selectedDate = selectedDate
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack {
                    AsyncImage(url: URL(string: product.image ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 140, height: 200)
                    .background(.placeholder)
                    
                    Text(product.name)
                        .font(.title)
                        .fontWeight(.medium)
                    
                    Text(product.description)
                        .font(.footnote)
                }
                .frame(maxWidth: .infinity)
                
                HStack {
                    Text("가 격")
                        .font(.title3)
                        .bold()
                    
                    Spacer()
                    
                    Text(product.price.formatted() + "원")
                        .bold()
                }
                
                Divider()
                
                if !product.optionList.isEmpty {
                    VStack(alignment: .leading) {
                        Text("추가 옵션")
                            .font(.headline)
                            .bold()
                        
                        ForEach($product.optionList) { $option in
                            AdditionalProductOptionCell(option: $option)
                        }
                    }
                    
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("희망 날짜")
                            .font(.headline)
                            .bold()

                        Spacer()
                        
                        Text(selectedDate.formatted())
                    }
                    .padding(.bottom, 10)
                    
                    BookingTimePicker(
                        selectedDate: $selectedDate,
                        openedHoursArr: [])
                }
                
                Button(
                    action: {
                        navigationManager.push(
                            .orderView(
                                studio: studio,
                                product: product,
                                totalPrice: totalPrice,
                                selectedDate: selectedDate
                            )
                        )
                    },
                    label: {
                    Capsule()
                        .fill(.yellow)
                        .frame(height: 40)
                        .overlay {
                            Text("주문하기 (₩\(totalPrice))")
                                .tint(.black)
                        }
                })
            }
            .padding(.horizontal, 36)
        }
    }
}

#Preview {
    NavigationStack {
        StudioProductDetailView(studio: .mockData(), product: .mockData[0])
    }
}
