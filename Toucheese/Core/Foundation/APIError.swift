//
//  APIError.swift
//  Toucheese
//
//  Created by 유지호 on 11/19/24.
//

import Foundation

enum APIError: Error, Equatable {
    case network(statusCode: Int, response: ErrorEntity)
    case tokenReissuanceFailed
    case unknown
    
    init(error: Error, statusCode: Int? = 0, response: ErrorEntity) {
        guard let statusCode else {
            self = .unknown
            return
        }
        
        self = .network(statusCode: statusCode, response: response)
    }
}
