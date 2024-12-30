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
    case getList
    case detail(orderID: Int)
    case update(orderId: Int, order: UpdateOrderEntity)
}

extension OrderAPI: BaseAPI {
    
    static var apiType: APIType = .order
    
    var path: String {
        switch self {
        case .create:
            "/create"
        case let .cancel(orderID):
            "/\(orderID)/cancel"
        case .getList:
            "schedule"
        case let .detail(orderID):
            "/\(orderID)/schedule/detailed"
        case let .update(orderId, _):
            "\(orderId)/schedule/modify"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .create : .post
        case .cancel, .update: .put
        case .getList, .detail: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .create(order):
            return .requestCustomJSONEncodable(order, encoder: JSONEncoder())
        case let .update(_, order):
            return .requestCustomJSONEncodable(order, encoder: JSONEncoder())
        case .cancel, .getList, .detail:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        HeaderType.jsonWithToken.value
    }
    
}
