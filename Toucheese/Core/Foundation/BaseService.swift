//
//  BaseService.swift
//  Toucheese
//
//  Created by 유지호 on 11/19/24.
//

import Foundation
import Combine
import Alamofire
import Moya

class BaseService<Target: TargetType> {
 
    typealias API = Target
    
    var bag = Set<AnyCancellable>()
    
    lazy var provider = defaultProvider
    
    
    // MARK: Provider
    private lazy var defaultProvider: MoyaProvider<API> = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let interceptor = ToucheeseInterceptor()
        let session = Session(configuration: configuration, delegate: .init(), interceptor: interceptor)
        let provider = MoyaProvider<API>(
            endpointClosure: endpointClosure,
            session: session,
            plugins: [LoggingPlugin()]
        )
        
        return provider
    }()
    
//    private lazy var testingProvider: MoyaProvider<API> = {
//        let testingProvider = MoyaProvider<API>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
//        return testingProvider
//    }()
//    
//    private lazy var testingProviderWithError: MoyaProvider<API> = {
//        let testingProvider = MoyaProvider<API>(endpointClosure: endpointClosureWithError, stubClosure: MoyaProvider.immediatelyStub)
//        return testingProvider
//    }()
    
    
    // MARK: Endpoint Closure
    private let endpointClosure = { (target: API) -> Endpoint in
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        var endpoint = Endpoint(
            url: url,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
        
        return endpoint
    }
    
    private let endpointClosureWithError = { (target: API) -> Endpoint in
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        var endpoint = Endpoint(
            url: url,
            sampleResponseClosure: { .networkResponse(400, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
        return endpoint
    }
    
}


extension BaseService {
    
    func requestObjectWithNetworkError<T: Decodable>(_ target: API) -> AnyPublisher<T, Error> {
        return Future { [weak self] promise in
            self?.provider.request(target) { result in
                switch result {
                case .success(let value):
                    do {
                        guard let response = value.response else { return }
                        
                        // TODO: 서버에서 Response 타입 정의가 완료되면 분기처리 제거
                        if target.path == "/sign-in/oauth" {
                            let body = try JSONDecoder().decode(BaseEntity<T>.self, from: value.data)
                            
                            switch response.statusCode {
                            case 200..<400:
                                if let payload = body.payload {
                                    promise(.success(payload))
                                } else {
                                    throw ErrorEntity(code: -1000, message: "Unknown Error")
                                }
                            case 400..<500:
                                if let error = body.error {
                                    promise(.failure(error))
                                } else {
                                    throw ErrorEntity(code: -1000, message: "Unknown Error")
                                }
                            default: break
                            }
                        } else {
                            switch response.statusCode {
                            case 200..<400:
                                let body = try JSONDecoder().decode(T.self, from: value.data)
                                promise(.success(body))
                            case 400..<500:
                                let body = try JSONDecoder().decode(ErrorEntity.self, from: value.data)
                                promise(.failure(body))
                            default: break
                            }
                        }
                    } catch {
                        // decoding error
                        promise(.failure(error))
                    }
                // 유효하지 않은 statusCode에 대한 처리
                case .failure(let error):
                    if case MoyaError.underlying(let error, _) = error,
                       case AFError.requestRetryFailed(let retryError, _) = error,
                       let retryError = retryError as? ErrorEntity,
                       retryError.code == 4016 {
                        promise(.failure(retryError))
                    } else {
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
}
