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
    
    @State private var offset: CGSize = CGSize()

    private var calendar = Calendar(identifier: .gregorian)
    private var weekdaySymbols: [String] = []
    
    init(selectedDate: Binding<Date>, month: Binding<Date>, calendar: Foundation.Calendar = Calendar.current) {
        self._selectedDate = selectedDate
        self._month = month
        self.calendar = calendar
        self.weekdaySymbols = calendar.shortWeekdaySymbols
    }
    
    var body: some View {
        VStack {
            headerView
            calendarGridView
        }
//        .onAppear {
//            month = selectedDate
//        }
    }
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            HStack {
                Button {
                    changeMonth(by: -1)
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color(UIColor.label))
                }
                
                Text(month, formatter: Self.dateFormatter)
                    .font(.headline)
                
                Button {
                    changeMonth(by: 1)
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color(UIColor.label))
                }
            }
            .padding(.bottom)
            
            HStack {
                ForEach(weekdaySymbols, id: \.self) { symbol in
//                    TODO: Sun과 Sat은 절대 다수이나 전체 국가는 아니므로 다른 언어로(혹은 다른 스펠링으로) 나오게 될 경우에는 어떻게 처리할 지 고려해봐야함.(단순히 모든 locale의 경우를 다 때려박는거 말고)
                    if symbol == "Sun" {
                        Text(symbol)
                            .foregroundStyle(Color.red)
                            .font(.subheadline)
                            .bold()
                            .frame(maxWidth: .infinity)
                    } else if symbol == "Sat" {
                        Text(symbol)
                            .foregroundStyle(Color.blue)
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
            Divider()
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
                        
                        CellView(day: day)
                            .foregroundStyle(Color(UIColor.label))
                            .padding(.vertical)
                            .onTapGesture {
                                selectedDate = date
                            }
                            .overlay {
                                Circle()
                                    .stroke(selectedDate.isSameDay(as: date) ? .yellow : .clear,
                                            lineWidth: 4)
                            }
                    }
                }
            }
        }
    }
}

// MARK: - 일자 셀 뷰
private struct CellView: View {
    var day: Int
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .opacity(0)
                .overlay(Text(String(day)))
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
            let newDate = calendar.date(from: calendar.dateComponents([.year, .month], from: month))
            self.selectedDate = newDate!
        }
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
}

//#Preview {
//    let october2024 = Calendar.current.date(from: DateComponents(year: 2024, month: 11))!
//
//    CustomCalendar(selectedDate: .constant(Date()))
//}
