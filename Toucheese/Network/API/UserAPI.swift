//
//  UserAPI.swift
//  Toucheese
//
//  Created by SunJoon Lee on 12/30/24.
//

import Moya
import Alamofire

enum UserAPI {
    case detail
}

extension UserAPI: BaseAPI {
    
    static var apiType: APIType = .auth
    
    var path: String {
        switch self {
        case .detail:
            "/details"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .detail: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .detail: .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .detail:
            HeaderType.jsonWithToken.value
        }
    }
    
}

