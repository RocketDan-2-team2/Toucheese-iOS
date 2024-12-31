//
//  StudioProductDetailView.swift
//  Toucheese
//
//  Created by 유지호 on 11/29/24.
//

import SwiftUI
import Combine

struct StudioProductDetailView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let studio: StudioInfo
    
    let hoursRawData: [StudioHoursEntity]
    
    @State private var product: StudioProduct
    
    @State private var selectedDate: Date = .now
    
    @State private var bag = Set<AnyCancellable>()
    
    @State private var showCalendar: Bool = false
        
    @State private var studioHours: [[Int]] = Array(repeating: [], count: 31)
    
    @State private var isTimeSelected: Bool = false
    
    @State private var user: User?
    
    let studioService: StudioService = DefaultStudioService()
    let userService: UserService = DefaultUserService()
    
    var totalPrice: Int {
        product.optionList.reduce(product.price) {
            $0 + $1.price * $1.count
        }
    }

    init(studio: StudioInfo, product: StudioProduct, hoursRawData: [StudioHoursEntity]) {
        self.studio = studio
        self.product = product
        self.hoursRawData = hoursRawData
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
                        hoursRawData: hoursRawData,
                        isTimeSelected: $isTimeSelected)
                    .onChange(of: selectedDate) { oldValue, newValue in
                        let calendar = Calendar.current
                        if calendar.component(.month, from: oldValue) != calendar.component(.month, from: newValue) {
                            fetchStudioHours(month: newValue)
                        }
                    }
                    .task {
                        fetchStudioHours(month: selectedDate)
                    }
                }
                
                if isTimeSelected {
                    Button(
                        action: {
                            if let user {
                                navigationManager.push(
                                    .orderView(
                                        studio: studio,
                                        product: product,
                                        totalPrice: totalPrice,
                                        selectedDate: selectedDate,
                                        user: user
                                    )
                                )
                            }
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
                } else {
                    Button {
                    } label: {
                        Capsule()
                            .fill(.gray03)
                            .frame(height: 40)
                            .overlay {
                                Text("날짜를 선택해주세요.")
                                    .tint(.gray05)
                            }
                    }
                }
            }
            .padding(.horizontal, 36)
        }
        .onAppear {
            fetchUserDetail()
        }
    }
    
    private func fetchUserDetail() {
        userService.detail()
            .sink { event in
                switch event {
                case .finished:
                    print(event)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { user in
                self.user = user.translate()
                print("user!\(user.nickname)")
            }
            .store(in: &bag)
    }
    
    private func fetchStudioHours(month: Date) {
        
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: month) else { return }
        let numberOfDays = range.count
        guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month)) else { return }
        
        var result: [[Int]] = Array(repeating: [], count: numberOfDays)
        
        let dayOfWeekMapping: [String: Int] = [
            "SUNDAY": 1,
            "MONDAY": 2,
            "TUESDAY": 3,
            "WEDnesday": 4,
            "THursday": 5,
            "FRIDAY": 6,
            "SATURDAY": 7
        ]
        
        studioService.getStudioHours(studioID: studio.id)
            .sink { event in
                switch event {
                case .finished:
                    print("Event: \(event)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { datas in
                for data in datas {
                    guard let weekday = dayOfWeekMapping[data.dayOfWeek] else { continue }
                    print("weekdays",weekday)
                    
                    if data.holiday {
                        continue
                    }
                    
                    let timeFormatter = DateFormatter()
                    timeFormatter.dateFormat = "HH:mm"
                    
                    guard
                        let openTime = timeFormatter.date(from: data.openTime),
                        let closeTime = timeFormatter.date(from: data.closeTime)
                    else { continue }
                    
                    print("onoffTimes", openTime, closeTime)
                    
                    let openHour = calendar.component(.hour, from: openTime)
                    let closeHour = calendar.component(.hour, from: closeTime)
                    
                    print("openHour, closeHour", openHour, closeHour)
                    
                    for day in 1...numberOfDays {
                        guard
                            let currentDate = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth),
                            calendar.component(.weekday, from: currentDate) == weekday
                        else { print("guard문에서 실패함"); continue }
                        
                        let index = day - 1
                        result[index] = Array(openHour..<closeHour)
                    }
                }
                studioHours = result
                print(result)
            }
            .store(in: &bag)

    }
}

#Preview {
    NavigationStack {
//        StudioProductDetailView(studio: .mockData(), product: .mockData[0], openedHours: <#Binding<[[Int]]>#>)
    }
}
