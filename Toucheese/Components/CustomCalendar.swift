//
//  CustomCalendar.swift
//  Toucheese
//
//  Created by woong on 11/27/24.
//

import SwiftUI

struct CustomCalendar: View {
    @Binding var selectedDate: Date
    
    @State private var month: Date = Date()
    @State var offset: CGSize = CGSize()
    
    var body: some View {
        VStack {
            headerView
            calendarGridView
        }
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
                ForEach(Self.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.subheadline)
                        .bold()
                        .frame(maxWidth: .infinity)
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
                                    .stroke(selectedDate == date ? .yellow : .clear,
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
    
    static let weekdaySymbols = Calendar.current.shortWeekdaySymbols
}

#Preview {
    let october2024 = Calendar.current.date(from: DateComponents(year: 2024, month: 11))!
    
    CustomCalendar(selectedDate: .constant(Date()))
}
