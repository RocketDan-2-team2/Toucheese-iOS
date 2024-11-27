//
//  Calendar.swift
//  Toucheese
//
//  Created by woong on 11/26/24.
//

import SwiftUI

struct BookingTimePicker: View {
    @Binding var selectedDate: Date
    @Binding var selectedTime: Int
    
    @State var closedDays: [Int]?
    @State var openedHours: [Int]
    
    private let gridRow = Array(repeating: GridItem(.adaptive(minimum: .infinity, maximum: .infinity)), count: 4)
    
    @State private var selectedButton: Int?
    
    var body: some View {
        VStack {
            RepresentableCalendar(closedDays: $closedDays)
            
            //            MARK: 하단 시간 선택 버튼
            VStack {
                VStack {
                    HStack {
                        Text("오전")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.leading, 10)
                    
                    TimeButtonGrid(columnsArr: gridRow,
                                   timeArr: openedHours,
                                   selectedTime: $selectedTime,
                                   selectedButton: $selectedButton,
                                   isAM: true)
                }
                .padding(.vertical)
                
                VStack {
                    HStack {
                        Text("오후")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.leading, 10)
                    
                    TimeButtonGrid(columnsArr: gridRow,
                                   timeArr: openedHours,
                                   selectedTime: $selectedTime,
                                   selectedButton: $selectedButton,
                                   isAM: false)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    BookingTimePicker(selectedDate: .constant(Date()), selectedTime: .constant(10), openedHours: [])
}

struct TimeButtonGrid: View {
    let columnsArr: [GridItem]
    let timeArr: [Int]
    
    @Binding var selectedTime: Int
    @Binding var selectedButton: Int?
    
    let isAM: Bool
    
    private let backgroundColor = Color(cgColor: CGColor(red: 255/255.0, green: 242/255.0, blue: 204/255.0, alpha: 1.0))
    
    var body: some View {
        if timeArr.count == 0 {
            Text("쉬는 날 입니다.")
                .bold()
        } else {
            LazyVGrid(columns: columnsArr) {
                ForEach(filteredTimes.indices, id: \.self) { idx in
                    Button {
                        selectedTime = filteredTimes[idx]
                        selectedButton = idx + offset
                    } label: {
                        let tempNum: Int = filteredTimes[idx] <= 12 ? filteredTimes[idx] : filteredTimes[idx] - 12
                        Text("\(tempNum):00")
                            .foregroundStyle(.black)
                            .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                            .frame(maxWidth: .infinity)
                            .background(Capsule().fill(backgroundColor))
                            .overlay {
                                Capsule()
                                    .stroke(selectedButton == idx + offset ? .yellow : backgroundColor, lineWidth: 5)
                            }
                    }
                }
            }
        }
        
        
    }
    
    private var filteredTimes: [Int] {
        isAM ? timeArr.filter { $0 < 12 } : timeArr.filter { $0 >= 12 }
    }

    private var offset: Int {
        isAM ? 0 : timeArr.filter { $0 < 12 }.count
    }
}

