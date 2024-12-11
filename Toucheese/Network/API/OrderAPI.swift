//
//  OrderAPI.swift
//  Toucheese
//
//  Created by 최주리 on 12/10/24.
//

import Alamofire
import Moya
import Foundation

enum OrderAPI {
    case create(order: OrderEntity)
}

extension OrderAPI: BaseAPI {
    
    static var apiType: APIType = .order
    
    var path: String {
        switch self {
        case .create:
            "/create"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .create : .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .create(let order):
            do {
                let jsonData = try JSONEncoder().encode(order)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("Encoded JSON: \(jsonString)")
                }
            } catch {
                print("Failed to encode order: \(error)")
            }
            return .requestCustomJSONEncodable(order, encoder: JSONEncoder())
        }
    }
    
    var headers: [String : String]? {
        HeaderType.json.value
    }
    
}
