//
//  Calendar.swift
//  Toucheese
//
//  Created by woong on 11/26/24.
//

import SwiftUI

struct BookingTimePicker: View {
    @Binding var selectedDate: Date
    let hoursRawData: [StudioHoursEntity]
    
    @State private var selectedTime: Int = 0
    @State private var selectedButton: Int = 0
    
    @State private var isFirstInit: Bool = true
    
    private let gridRow = Array(repeating: GridItem(.adaptive(minimum: .infinity, maximum: .infinity)), count: 4)
    
    private var calculatedTime: Int {
        let df = DateFormatter()
        df.dateFormat = "HH"
        df.timeZone = TimeZone.autoupdatingCurrent
        let dateString = df.string(from: selectedDate)
        return Int(dateString)!
    }
    
    private var openedHoursArr: [[Int]] {
        return convertDataToHours(datas: hoursRawData, month: month)
    }
    
    //이차원 배열로 시간을 받기위해 인덱스로 사용하려고 만들어진 일자 변수.
    //처음에 selectedDate가 binding으로 현재 Date() 인스턴스를 받는다고 가정해서 언래핑함.
    //인덱스로 쓸거라서 마지막에 -1 함.
    private var calculatedDate: Int {
        let df = DateFormatter()
        df.dateFormat = "d"
        df.timeZone = TimeZone.autoupdatingCurrent
        let temp = df.string(from: selectedDate)
        return Int(temp)! - 1
    }
    
    private var buttonIndex: Int {
        if let index = openedHoursArr.firstIndex(of: [calculatedTime]) {
            return index
        } else {
            if openedHoursArr.isEmpty {
                return 0
            } else {
                var maxNumIdx = 0
                for i in 0..<openedHoursArr[calculatedDate].count {
                    if openedHoursArr[calculatedDate][i] <= calculatedTime {
                        maxNumIdx = i
                    } else { break }
                }
                return maxNumIdx
            }
        }
    }
    
    @State private var month = Date()
    
    var body: some View {
        VStack {
            CustomCalendar(selectedDate: $selectedDate, month: $month)
                .onChange(of: month) { oldValue, newValue in
                    print("newValue:", newValue)
                }
            
            //            MARK: 하단 시간 선택 버튼
            VStack {
                VStack {
                    HStack {
                        Text("오전")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.leading, 10)
                    
                    TimeButtonGrid(selectedTime: $selectedTime,
                                   selectedButton: $selectedButton,
                                   columnsArr: gridRow,
                                   timeArr: openedHoursArr[calculatedDate],
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
                    
                    TimeButtonGrid(selectedTime: $selectedTime,
                                   selectedButton: $selectedButton,
                                   columnsArr: gridRow,
                                   timeArr: openedHoursArr[calculatedDate],
                                   isAM: false)
                }
            }
            .onChange(of: selectedTime, { _, newValue in
                updateSelectedDateWithTime(time: newValue)
            })
        }
        .onChange(of: selectedDate) { oldValue, newValue in
            if openedHoursArr[calculatedDate].isEmpty == false {
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd"
                let oldDate = df.string(from: oldValue)
                let newDate = df.string(from: newValue)
                
                if oldDate != newDate {
                    selectedButton = 0
                    selectedTime = openedHoursArr[calculatedDate][0]
                }
                
                updateSelectedDateWithTime(time: selectedTime)
                
            } else {
                selectedTime = 0
            }
        }
        .onAppear {
            selectedTime = calculatedTime
            selectedButton = buttonIndex
        }
    }
    
    private func updateSelectedDateWithTime(time: Int) {
        var component = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate)
        component.hour = time
        component.minute = 0
        component.second = 0
        
        if let updatedDate = Calendar.current.date(from: component), updatedDate != selectedDate {
            selectedDate = updatedDate
        }
    }
    
    private func convertDataToHours(datas: [StudioHoursEntity], month: Date) -> [[Int]] {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: month) else { return [] }
        let numberOfDays = range.count
        guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month)) else { return [] }
        
        var result: [[Int]] = Array(repeating: [], count: numberOfDays)
        
        let dayOfWeekMapping: [String: Int] = [
            "SUNDAY": 1,
            "MONDAY": 2,
            "TUESDAY": 3,
            "WEDNESDAY": 4,
            "THURSDAY": 5,
            "FRIDAY": 6,
            "SATURDAY": 7
        ]
        
        for data in datas {
            print("start convert data")
            guard let weekday = dayOfWeekMapping[data.dayOfWeek] else { continue }
            print("weekdays",weekday)
            
            if data.holiday {
                continue
            }
            print("not holiday")
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm:ss"
            
            guard
                let openTime = timeFormatter.date(from: data.openTime),
                let closeTime = timeFormatter.date(from: data.closeTime)
            else { print("onoffTimes 형식이 잘못되었습다");continue }
            
            print("onoffTimes", openTime, closeTime)
            
            let openHour = calendar.component(.hour, from: openTime)
            let closeHour = calendar.component(.hour, from: closeTime)
            
            print("openHour, closeHour", openHour, closeHour)
            
            for day in 0..<numberOfDays {
                guard
                    let currentDate = calendar.date(byAdding: .day, value: day, to: startOfMonth)
                else { print("currentDate 계산 guard문에서 실패함"); continue }
                
                guard calendar.component(.weekday, from: currentDate) == weekday else { print("요일 체크 계산 guard문에서 실패함"); continue }
                
                let index = day
                result[index] = Array(openHour..<closeHour)
            }
        }
        print("openedHours",result)
        return result
        
    }
}

//#Preview {
//    BookingTimePicker(selectedDate: .constant(Date()), openedHoursArr: [[1,2,3,4],[9,10,11,13,14,15],[]])
//}

struct TimeButtonGrid: View {
    @Binding var selectedTime: Int
    @Binding var selectedButton: Int
    
    let columnsArr: [GridItem]
    let timeArr: [Int]
    
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
                            .padding(2)
                            .frame(maxWidth: .infinity)
                            .background(Capsule().fill(buttonYellow))
                            .overlay {
                                Capsule()
                                    .stroke(selectedButton == idx + offset ? .yellow : buttonYellow, lineWidth: 5)
                            }
                    }
                    .padding(2)
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

