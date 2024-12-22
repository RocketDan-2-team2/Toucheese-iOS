//
//  BaseAPI.swift
//  Toucheese
//
//  Created by 유지호 on 11/19/24.
//

import Foundation
import Moya

protocol BaseAPI: TargetType {
    static var apiType: APIType { get set }
}


extension BaseAPI {
    
    var baseURL: URL {
        var base = ToucheeseEnv.Network.baseURL
        
        switch Self.apiType {
        case .auth:
            base += "/auth"
        case .studio:
            base += "/studio"
        case .order:
            base += "/order"
        }
        
        guard let url = URL(string: base) else {
          fatalError("baseURL could not be configured")
        }
        
        return url
    }
    
    var headers: [String: String]? {
        return HeaderType.jsonWithToken.value
    }
    
    var validationType: ValidationType {
        return .customCodes(Array(200..<500))
    }
}


enum APIType {
    case auth
    case studio
    case order
}

enum HeaderType {
    case json
    case jsonWithToken
    case multipartWithToken
    
    public var value: [String: String] {
        switch self {
        case .json:
            return ["Content-Type": "application/json"]
        case .jsonWithToken:
            return ["Content-Type": "application/json",
                    "Authorization": "accountToken"]
        case .multipartWithToken:
            return ["Content-Type": "multipart/form-data",
                    "Authorization": "accountToken"]
        }
    }
}
