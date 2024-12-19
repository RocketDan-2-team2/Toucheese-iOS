//
//  CustomCalendar.swift
//  Toucheese
//
//  Created by woong on 11/27/24.
//

import SwiftUI

struct CustomCalendar: View {
    @Binding var selectedDate: Date
    @Binding var month: Date
    let holidaySymbols: [String]
    
    @State private var offset: CGSize = CGSize()
    
    @State private var isDownButtonDisabled: Bool = false
    @State private var isUpButtonDisabled: Bool = false
    
    @State private var leftChevronColor: Color = .black
    @State private var rightChevronColor: Color = .black
    
    private var calculatedHolidaySymbols: [Int] {
        var tempSymbols: [Int] = []
        for i in holidaySymbols {
            switch i {
            case "SUNDAY":
                tempSymbols.append(1)
            case "MONDAY":
                tempSymbols.append(2)
            case "TUESDAY":
                tempSymbols.append(3)
            case "WEDNESDAY":
                tempSymbols.append(4)
            case "THURSDAY":
                tempSymbols.append(5)
            case "FRIDAY":
                tempSymbols.append(6)
            case "SATURDAY":
                tempSymbols.append(7)
            default:
                continue
            }
        }
        
        return tempSymbols
    }

    private var calendar = Calendar(identifier: .gregorian)
    private var weekdaySymbols: [String] = ["일","월","화","수","목","금","토",]
    
    init(selectedDate: Binding<Date>, month: Binding<Date>, holidaySymbols: [String], calendar: Foundation.Calendar = Calendar.current) {
        self._selectedDate = selectedDate
        self._month = month
        self.calendar = calendar
        self.holidaySymbols = holidaySymbols
    }
    
    var body: some View {
        VStack {
            headerView
            calendarGridView
        }
        .onAppear {
            updateButtonStates()
        }
    }
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            HStack {
                Button {
                    changeMonth(by: -1)
                    updateButtonStates() // 버튼 상태 업데이트 호출
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(leftChevronColor)
                }
                .disabled(isDownButtonDisabled) // 비활성화 처리

                Text(month, formatter: Self.dateFormatter)
                    .font(.headline)
                
                Button {
                    changeMonth(by: 1)
                    updateButtonStates() // 버튼 상태 업데이트 호출
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(rightChevronColor)
                }
                .disabled(isUpButtonDisabled) // 비활성화 처리

            }
            .padding(.bottom)
            
            HStack {
                ForEach(weekdaySymbols, id: \.self) { symbol in
//                    TODO: Sun과 Sat은 절대 다수이나 전체 국가는 아니므로 다른 언어로(혹은 다른 스펠링으로) 나오게 될 경우에는 어떻게 처리할 지 고려해봐야함.(단순히 모든 locale의 경우를 다 때려박는거 말고)
                    if symbol == "일" {
                        Text(symbol)
                            .foregroundStyle(Color.red)
                            .font(.subheadline)
                            .bold()
                            .frame(maxWidth: .infinity)
                    } else {
                        Text(symbol)
                            .font(.subheadline)
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                    
                }
            }
        }
    }
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        
        return VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(0 ..< daysInMonth + firstWeekday, id: \.self) { index in
                    if index < firstWeekday {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.clear)
                    } else {
                        let date = getDate(for: index - firstWeekday)
                        let day = index - firstWeekday + 1
                        let color = getDayColor(for: day)
                        
                        CellView(day: day, color: color)
                            .padding(.vertical)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(selectedDate.isSameDay(as: date) ? .yellow : Color.gray01)
                            }
                            .onTapGesture {
                                let today = Calendar.current.startOfDay(for: Date())
                                let startOfTargetDate = Calendar.current.startOfDay(for: date)
                                
                                // 현재 달인지 확인
                                let isCurrentMonth = Calendar.current.isDate(month, equalTo: today, toGranularity: .month)
                                
                                let weekday = Calendar.current.component(.weekday, from: date)
                                let weekdayResult = calculatedHolidaySymbols.contains(weekday)
                                
                                // 현재 달이고 오늘보다 이전 날짜라면 선택 불가
                                if isCurrentMonth && startOfTargetDate < today {
                                    print("아무 동작도 하지 않음")
                                    return // 아무 동작도 하지 않음
                                }
                                
                                if weekdayResult {
                                    print("쉬는날이라 아무 동작도 하지 않음")
                                    return
                                }
                                
                                // 선택 가능한 경우에만 날짜 업데이트
                                selectedDate = date
                            }
                    }
                }
            }
        }
    }
}

// MARK: - 일자 셀 뷰
private struct CellView: View {
    let day: Int
//    TODO: 컬러 받아주기
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .opacity(0)
            .overlay {
                Text(String(day))
                    .foregroundStyle(color)
            }
        
    }
}

// MARK: - 내부 메서드
private extension CustomCalendar {
    /// 특정 해당 날짜
    private func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth())!
    }
    
    /// 해당 월의 시작 날짜
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        return Calendar.current.date(from: components)!
    }
    
    /// 해당 월에 존재하는 일자 수
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    /// 월 변경
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: month) {
            self.month = newMonth
            
            if calendar.dateComponents([.year, .month], from: newMonth) == calendar.dateComponents([.year, .month], from: Date()) {
                self.selectedDate = Date()
                return
            }
            let newDate = calendar.date(from: calendar.dateComponents([.year, .month], from: month))
            self.selectedDate = newDate!
        }
    }

    
    func updateButtonStates() {
        let today = Calendar.current.startOfDay(for: Date())
        
        // 왼쪽 chevron 버튼 상태 업데이트 (현재 날짜보다 이전으로 이동 불가)
        if Calendar.current.startOfDay(for: month) <= today {
            isDownButtonDisabled = true
            leftChevronColor = Color.gray.opacity(0.5) // 비활성화 시 회색으로 표시
        } else {
            isDownButtonDisabled = false
            leftChevronColor = Color.black // 활성화 시 검정색으로 표시
        }

        // 오른쪽 chevron 버튼 상태 업데이트 (오늘 날짜 기준 최대 1년 이후까지만 이동 가능)
        let oneYearLater = Calendar.current.date(byAdding: .year, value: 1, to: today)!
        if Calendar.current.startOfDay(for: month) >= oneYearLater {
            isUpButtonDisabled = true
            rightChevronColor = Color.gray.opacity(0.5) // 비활성화 시 회색으로 표시
        } else {
            isUpButtonDisabled = false
            rightChevronColor = Color.black // 활성화 시 검정색으로 표시
        }
    }

    
    func getDayColor(for day: Int) -> Color {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month], from: month)
        components.day = day
        let targetDate = calendar.date(from: components)!
        
        // 오늘 날짜와 비교를 위한 변수
        let today = calendar.startOfDay(for: Date())
        let startOfTargetDate = calendar.startOfDay(for: targetDate)
        
        // 현재 달인지 확인
        let isCurrentMonth = calendar.isDate(month, equalTo: today, toGranularity: .month)
        
        // 휴일 확인 (예: 일요일, 토요일 등)
        let weekday = calendar.component(.weekday, from: targetDate)
        let isHoliday = calculatedHolidaySymbols.contains(weekday)
        
        // 현재 달이고 오늘보다 이전 날짜라면 비활성화 색상 반환
        if isCurrentMonth && startOfTargetDate < today {
            return Color.gray.opacity(0.5) // 비활성화 색상
        }
        
        // 휴일이라면 비활성화 색상 반환
        if isHoliday {
            return Color.gray.opacity(0.5) // 휴일 비활성화 색상
        }
        
        // 일요일은 빨간색 표시
        if weekday == 1 {
            return Color.red
        }
        
        // 기본적으로 검정색 반환
        return Color.black
    }


}

// MARK: - Static 프로퍼티
extension CustomCalendar {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MM월"
        return formatter
    }()
}

extension Date {
    func isSameDay(as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day], from: self)
        let components2 = calendar.dateComponents([.year, .month, .day], from: otherDate)
        return components1 == components2
    }
    
    func getYearNMonth() -> DateComponents {
        let result = Calendar.current.dateComponents([.year, .month], from: self)
        return result
    }
}

#Preview {
//    @State var october2024 = Calendar.current.date(from: DateComponents(year: 2024, month: 11))!
    @State var october2024 = Date()

    CustomCalendar(selectedDate: $october2024, month: $october2024, holidaySymbols: ["일","월"])
}
