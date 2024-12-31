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
    case nicknameCheck(parameters: Parameters)
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
        case .nicknameCheck:
            "/nickname/check"
        case .profileUpdate:
            "profile/update"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn, .reissuance, .nicknameCheck: .post
        case .profileUpdate: .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .signIn(let parameters), .nicknameCheck(let parameters), .profileUpdate(let parameters):
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
        case .reissuance, .nicknameCheck, .profileUpdate:
            HeaderType.jsonWithToken.value
        }
    }
    
}

