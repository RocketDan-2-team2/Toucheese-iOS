//
//  OrderService.swift
//  Toucheese
//
//  Created by 최주리 on 12/10/24.
//

import Foundation
import Combine
import Moya

protocol OrderService {
    func createOrder(order: OrderEntity) -> AnyPublisher<Bool, Error>
    func cancelOrder(orderID: Int) -> AnyPublisher<Bool, Error>
}

final class DefaultOrderService: BaseService<OrderAPI> { }

extension DefaultOrderService: OrderService {
    
    func createOrder(order: OrderEntity) -> AnyPublisher<Bool, any Error> {
        requestObjectWithNetworkError(.create(order: order))
    }
    
    func cancelOrder(orderID: Int) -> AnyPublisher<Bool, any Error> {
        requestObjectWithNetworkError(.cancel(orderID: orderID))
    }

}

final class MockOrderService: BaseService<OrderAPI> { }

extension MockOrderService: OrderService {
    
    func createOrder(order: OrderEntity) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, any Error> { promise in
            let success: Bool = true
            promise(.success(success))
        }
        .eraseToAnyPublisher()
    }
    
    func cancelOrder(orderID: Int) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, any Error> { promise in
            let success: Bool = true
            promise(.success(success))
        }
        .eraseToAnyPublisher()
    }

}
