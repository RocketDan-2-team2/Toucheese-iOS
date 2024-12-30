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
    case profileUpdate(parameters: Parameters)
}

extension AuthAPI: BaseAPI {
    
    static var apiType: APIType = .auth
    
    var path: String {
        switch self {
        case .signIn:
            "/sign-in/oauth"
        case .reissuance:
            "/reissuance"
        case .profileUpdate:
            "profile/update"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn, .reissuance: .post
        case .profileUpdate: .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .signIn(let parameters), .profileUpdate(let parameters):
                .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .reissuance:
                .requestParameters(parameters: ["accessToken": UserDefaultsKey.Auth.accessToken ?? "",
                                                "refreshToken": UserDefaultsKey.Auth.refreshToken ?? ""],
                                   encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signIn:
            HeaderType.json.value
        case .reissuance, .profileUpdate:
            HeaderType.jsonWithToken.value
        }
    }
    
}

