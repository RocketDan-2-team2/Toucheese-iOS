//
//  String+Extension.swift
//  Toucheese
//
//  Created by 유지호 on 12/20/24.
//

import Foundation

extension String {
    
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
    
}
