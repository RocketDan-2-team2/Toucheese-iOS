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
    case cancel(orderID: Int)
}

extension OrderAPI: BaseAPI {
    
    static var apiType: APIType = .order
    
    var path: String {
        switch self {
        case .create:
            "/create"
        case let .cancel(orderID):
            "/\(orderID)/cancel"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .create : .post
        case let .cancel(orderID): .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .create(order):
            return .requestCustomJSONEncodable(order, encoder: JSONEncoder())
        case let .cancel(orderID):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        HeaderType.json.value
    }
    
}
