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
    
    private func validateHeader(_ urlRequest: inout URLRequest) {
        let headers = urlRequest.headers.map {
            guard $0.name == "Bearer Token" else { return $0 }
            
            return HTTPHeader(name: $0.name, value: UserDefaultsKey.Auth.accessToken ?? "none")
        }
        
        urlRequest.headers = HTTPHeaders(headers)
    }
    
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: any Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        // 비회원인 경우, 리프레쉬 토큰 만료 -> 로그인 유도
        // 엑세스 토큰 만료 -> 재발급
        guard let pathComponents = request.request?.url?.pathComponents,
              !pathComponents.contains("reissuance"),
              request.response?.statusCode == 403 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        DefaultAuthService().reissuance { isSuccessed in
            if isSuccessed {
                completion(.retry)
            } else {
                completion(.doNotRetryWithError(
                    ErrorEntity(code: 4016, message: "토큰 갱신 실패")
                ))
            }
        }
    }
    
}
