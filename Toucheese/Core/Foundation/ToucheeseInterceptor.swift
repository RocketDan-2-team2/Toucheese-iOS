//
//  ToucheeseInterceptor.swift
//  Toucheese
//
//  Created by 유지호 on 11/19/24.
//

import Foundation
import Alamofire

final class ToucheeseInterceptor: RequestInterceptor {
    
    public typealias AdapterResult = Result<URLRequest, Error>
    
    public func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var adaptedRequest = urlRequest
        validateHeader(&adaptedRequest)
        completion(.success(adaptedRequest))
    }
    
    // Note: 토큰 재발급 시 AccessToken 갱신
    private func validateHeader(_ urlRequest: inout URLRequest) {
        let headers = urlRequest.headers.map {
            guard $0.name == "Authorization" else { return $0 }
            return HTTPHeader(name: $0.name, value: "accountToken")
        }
        
        urlRequest.headers = HTTPHeaders(headers)
    }
    
}
