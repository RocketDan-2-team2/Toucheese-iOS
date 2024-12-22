//
//  AuthAPI.swift
//  Toucheese
//
//  Created by 유지호 on 12/21/24.
//

import Moya
import Alamofire

enum AuthAPI {
    case signIn(parameters: Parameters)
}

extension AuthAPI: BaseAPI {
    
    static var apiType: APIType = .auth
    
    var path: String {
        switch self {
        case .signIn:
            "/sign-in/oauth"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn: .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .signIn(let parameters):
                .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        HeaderType.json.value
    }
    
}

