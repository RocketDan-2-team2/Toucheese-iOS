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
    case reissuance
}

extension AuthAPI: BaseAPI {
    
    static var apiType: APIType = .auth
    
    var path: String {
        switch self {
        case .signIn:
            "/sign-in/oauth"
        case .reissuance:
            "/reissuance"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn, .reissuance: .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .signIn(let parameters):
                .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .reissuance:
                .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signIn:
            HeaderType.json.value
        case .reissuance:
            HeaderType.jsonWithToken.value
        }
    }
    
}

