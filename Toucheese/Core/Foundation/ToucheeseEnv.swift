//
//  ToucheeseEnv.swift
//  Toucheese
//
//  Created by 유지호 on 11/19/24.
//

import Foundation

enum ToucheeseEnv {
    
    enum Network {
        
        static let baseURL: String = {
            guard let urlString = infoDictionary["BASE_URL"] as? String else {
                fatalError("Base URL not set in plist for this environment")
            }
            
            return urlString
        }()
        
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        
        return dictionary
    }()
    
}
