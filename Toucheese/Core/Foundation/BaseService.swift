//
//  BaseService.swift
//  Toucheese
//
//  Created by 유지호 on 11/19/24.
//

import Foundation
import Combine
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
    
    private lazy var testingProvider: MoyaProvider<API> = {
        let testingProvider = MoyaProvider<API>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
        return testingProvider
    }()
    
    private lazy var testingProviderWithError: MoyaProvider<API> = {
        let testingProvider = MoyaProvider<API>(endpointClosure: endpointClosureWithError, stubClosure: MoyaProvider.immediatelyStub)
        return testingProvider
    }()
    
    
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
    
    var `default`: BaseService {
        self.provider = self.defaultProvider
        return self
    }
    
    var test: BaseService {
        self.provider = self.testingProvider
        return self
    }
    
    var testWithError: BaseService {
        self.provider = self.testingProviderWithError
        return self
    }
    
}


extension BaseService {
    
    func requestObjectWith<T: Decodable>(_ target: API) -> AnyPublisher<T, Error> {
        return Future { [weak self] promise in
            self?.provider.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let body = try JSONDecoder().decode(T.self, from: response.data)
                        promise(.success(body))
                    } catch {
                        promise(.failure(error))
                    }
                case .failure(let error):
                    // 여기서 필요에 의해 error 처리 가능
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func requestObjectWithNetworkError<T: Decodable>(_ target: API) -> AnyPublisher<T, Error> {
        return Future { [weak self] promise in
            self?.provider.request(target) { result in
                switch result {
                case .success(let value):
                    do {
                        guard let response = value.response else { return }
                        
                        switch response.statusCode {
                        case 200..<400:
                            let body = try JSONDecoder().decode(T.self, from: value.data)
                            promise(.success(body))
                        case 400..<500:
                            let body = try JSONDecoder().decode(ErrorResponse.self, from: value.data)
                            let apiError = APIError(
                                error: NSError(domain: "임시에러", code: -1001),
                                statusCode: response.statusCode,
                                response: body
                            )
                            
                            throw apiError
                        default: break
                        }
                    } catch {
                        promise(.failure(error))
                    }
                case .failure(let error):
                    // 여기서 필요에 의해 error 처리 가능
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
}