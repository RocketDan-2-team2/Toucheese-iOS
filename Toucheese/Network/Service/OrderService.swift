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
}

final class DefaultOrderService: BaseService<OrderAPI> { }

extension DefaultOrderService: OrderService {
    
    func createOrder(order: OrderEntity) -> AnyPublisher<Bool, any Error> {
        
        requestObjectWithNetworkError(.create(order: order))
    }

}

