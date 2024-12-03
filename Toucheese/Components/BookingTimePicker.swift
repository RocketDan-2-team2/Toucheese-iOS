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
    
    @State var openedHoursArr: [[Int]] = Array(repeating: [10,11,14,15,16,17,20,21,22], count: 31)
    
    private let tempOHArr = Array(repeating: [10,11,14,15,16,17,20,21,22], count: 31)
    
    private let gridRow = Array(repeating: GridItem(.adaptive(minimum: .infinity, maximum: .infinity)), count: 4)
    
    @State private var selectedButton: Int?
    
    ///이차원 배열로 시간을 받기위해 인덱스로 사용하려고 만들어진 일자 변수
    ///처음에 selectedDate가 binding으로 현재 Date() 인스턴스를 받는다고 가정해서 언래핑함.
    private var calculatedDate: Int {
        let df = DateFormatter()
        df.dateFormat = "d"
        let temp = df.string(from: selectedDate)
        return Int(temp)! - 1
    }
    
    var body: some View {
        VStack {
            CustomCalendar(selectedDate: $selectedDate)
            
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
                                   timeArr: tempOHArr[calculatedDate], //openedHoursArr[calculatedDate],
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
                                   timeArr: tempOHArr[calculatedDate], //openedHoursArr[calculatedDate],
                                   selectedTime: $selectedTime,
                                   selectedButton: $selectedButton,
                                   isAM: false)
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            print(openedHoursArr)
        }
    }
}

#Preview {
    BookingTimePicker(selectedDate: .constant(Date()), selectedTime: .constant(10), openedHoursArr: [[1,2,3,4],[9,10,11,13,14,15],[]])
}

struct TimeButtonGrid: View {
    let columnsArr: [GridItem]
    let timeArr: [Int]
    
    @Binding var selectedTime: Int
    @Binding var selectedButton: Int?
    
    let isAM: Bool
    
    private let buttonYellow = Color(cgColor: CGColor(red: 255/255.0, green: 242/255.0, blue: 204/255.0, alpha: 1.0))
    
    var body: some View {
        if timeArr.count == 0 {
            Text("운영중인 시간이 없습니다.")
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
                            .background(Capsule().fill(buttonYellow))
                            .overlay {
                                Capsule()
                                    .stroke(selectedButton == idx + offset ? .yellow : buttonYellow, lineWidth: 5)
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

