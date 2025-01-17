//
//  String+Extension.swift
//  Toucheese
//
//  Created by 유지호 on 12/20/24.
//

import Foundation

extension String {
    
    // MARK: Validation
    
    func isValidNickname() -> Bool {
        let nicknameRegex = "^(?:[가-힣]{1,7}|[a-zA-Z]{1,14})$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", nicknameRegex)
        return predicate.evaluate(with: self)
    }
    
    func isValidKoreanNickname() -> Bool {
        let nicknameRegex = "^[ㄱ-힣]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", nicknameRegex)
        return predicate.evaluate(with: self)
    }
    
    func isValidEnglishNickname() -> Bool {
        let nicknameRegex = "^[a-zA-Z]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", nicknameRegex)
        return predicate.evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+(?:\.com|\.net|\.co\.kr)"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
    
    
    
    // MARK: Date
    
    func toDate() -> Date? {
        return Date.isoFormatter.date(from: self)
    }
    
    func toDateReservation() -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MM월 dd일(E) a h시"

        if let date = formatter.date(from: self) {
            return date
            
        } else {
            return nil
        }
    }
    
}
