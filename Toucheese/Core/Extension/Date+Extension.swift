//
//  Date+Extension.swift
//  Toucheese
//
//  Created by 최주리 on 12/23/24.
//

import Foundation

extension Date {
    
    func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일(E) a h시"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: self)
    }
    
    //MARK: - Calendar
    
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
