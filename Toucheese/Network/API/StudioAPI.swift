//
//  StudioAPI.swift
//  Toucheese
//
//  Created by 유지호 on 11/20/24.
//

import Moya
import Alamofire

enum StudioAPI {
    case concept
    case search(conceptID: Int, parameters: Parameters)
    case studioDetailProduct(studioID: Int)
    case studioDetailReview(studioID: Int)
    case productDetail(itemID: Int)
}

extension StudioAPI: BaseAPI {
    
    static var apiType: APIType = .studio
    
    var path: String {
        switch self {
        case .concept:
            "/concepts"
        case .search(let conceptID, _):
            "/search/\(conceptID)"
        case .studioDetailProduct(let studioID):
            "/\(studioID)/items"
        case .studioDetailReview(let studioID):
            "/\(studioID)/reviews"
        case .productDetail(let itemID):
            "/item/\(itemID)/details"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .concept, .studioDetailProduct, .studioDetailReview, .productDetail: .get
        case .search : .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .concept, .studioDetailProduct, .studioDetailReview, .productDetail:
                .requestPlain
        case .search(_, let parameters):
                .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        HeaderType.json.value
    }
    
}
