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
    func getOrderList() -> AnyPublisher<[ReservationEntity], Error>
    func getOrderDetail(orderID: Int) -> AnyPublisher<ReservationDetail, Error>
}

final class DefaultOrderService: BaseService<OrderAPI> { }

extension DefaultOrderService: OrderService {
    
    func createOrder(order: OrderEntity) -> AnyPublisher<Bool, any Error> {
        requestObjectWithNetworkError(.create(order: order))
    }
    
    func cancelOrder(orderID: Int) -> AnyPublisher<Bool, any Error> {
        requestObjectWithNetworkError(.cancel(orderID: orderID))
    }
    
    func getOrderList() -> AnyPublisher<[ReservationEntity], any Error> {
        requestObjectWithNetworkError(.getList)
    }
    
    func getOrderDetail(orderID: Int) -> AnyPublisher<ReservationDetail, any Error> {
        requestObjectWithNetworkError(.detail(orderID: orderID))
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
    
    func getOrderList() -> AnyPublisher<[ReservationEntity], any Error> {
        return Future { promise in
            let list: [ReservationEntity] = [
                .init(
                    orderId: 0,
                    orderUserDto: OrderUserEntity(
                        userId: 0,
                        userName: "김멋사"
                    ),
                    studioName: "여기스튜디오",
                    reservedDateTime: "2024-12-28",
                    orderItemDto: [],
                    status: .cancel
                ),
                .init(
                    orderId: 0,
                    orderUserDto: OrderUserEntity(
                        userId: 0,
                        userName: "김멋사2"
                    ),
                    studioName: "저기스튜디오",
                    reservedDateTime: "2024-12-30",
                    orderItemDto: [],
                    status: .confirm
                ),
                .init(
                    orderId: 0,
                    orderUserDto: OrderUserEntity(
                        userId: 0,
                        userName: "김멋사"
                    ),
                    studioName: "여기스튜디오1",
                    reservedDateTime: "2024-12-28",
                    orderItemDto: [],
                    status: .waiting
                ),
            ]
            
            promise(.success(list))
        }
        .eraseToAnyPublisher()
    }
    
    func getOrderDetail(orderID: Int) -> AnyPublisher<ReservationDetail, any Error> {
        return Future { promise in
            let reservation: ReservationDetail = .init(
                studiName: "멋사 스튜디오",
                date: "2024-11-11",
                orderItem: "프로필B",
                ordererName: "강미미"
            )
            promise(.success(reservation))
        }
        .eraseToAnyPublisher()
    }
    
}
