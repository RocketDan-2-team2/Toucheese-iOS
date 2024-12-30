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
    func getOrderDetail(orderID: Int) -> AnyPublisher<[ReservationEntity], Error>
    func updateOrder(orderId: Int, order: UpdateOrderEntity) -> AnyPublisher<Bool, Error>
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
    
    func getOrderDetail(orderID: Int) -> AnyPublisher<[ReservationEntity], any Error> {
        requestObjectWithNetworkError(.detail(orderID: orderID))
    }
    
    func updateOrder(orderId: Int, order: UpdateOrderEntity) -> AnyPublisher<Bool, any Error> {
        requestObjectWithNetworkError(.update(orderId: orderId, order: order))
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
                    studioId: 0,
                    orderUserDto: OrderUserEntity(
                        userId: 0,
                        userName: "김멋사",
                        userEmail: "",
                        userPhone: ""
                    ),
                    studioName: "여기스튜디오",
                    reservedDateTime: "2024-12-28",
                    orderItemDto: OrderItemEntity(itemId: 0, itemName: "프로필A", itemImage: "", quantity: 1, itemPrice: 20000, totalPrice: 20000, orderOptionDtos: []),
                    status: .cancel,
                    studioImage: ""
                ),
                .init(
                    orderId: 0,
                    studioId: 0,
                    orderUserDto: OrderUserEntity(
                        userId: 0,
                        userName: "김멋사2",
                        userEmail: "",
                        userPhone: ""
                    ),
                    studioName: "저기스튜디오",
                    reservedDateTime: "2024-12-30",
                    orderItemDto: OrderItemEntity(itemId: 0, itemName: "프로필B", itemImage: "", quantity: 1, itemPrice: 20000, totalPrice: 20000, orderOptionDtos: []),
                    status: .confirm,
                    studioImage: ""
                ),
                .init(
                    orderId: 0,
                    studioId: 0,
                    orderUserDto: OrderUserEntity(
                        userId: 0,
                        userName: "김멋사",
                        userEmail: "",
                        userPhone: ""
                    ),
                    studioName: "여기스튜디오1",
                    reservedDateTime: "2024-12-28",
                    orderItemDto: OrderItemEntity(itemId: 0, itemName: "프로필C", itemImage: "", quantity: 1, itemPrice: 20000, totalPrice: 20000, orderOptionDtos: []),
                    status: .waiting,
                    studioImage: ""
                ),
                .init(
                    orderId: 0,
                    studioId: 0,
                    orderUserDto: OrderUserEntity(
                        userId: 0,
                        userName: "김멋사",
                        userEmail: "",
                        userPhone: ""
                    ),
                    studioName: "여기스튜디오1",
                    reservedDateTime: "2024-12-28",
                    orderItemDto: OrderItemEntity(itemId: 0, itemName: "프로필D", itemImage: "", quantity: 1, itemPrice: 20000, totalPrice: 20000, orderOptionDtos: []),
                    status: .finished,
                    studioImage: ""
                ),
            ]
            
            promise(.success(list))
        }
        .eraseToAnyPublisher()
    }
    
    func getOrderDetail(orderID: Int) -> AnyPublisher<[ReservationEntity], any Error> {
        return Future { promise in
            let list: [ReservationEntity] = [
                .init(
                    orderId: 0,
                    studioId: 0,
                    orderUserDto: OrderUserEntity(
                        userId: 0,
                        userName: "김멋사",
                        userEmail: "",
                        userPhone: ""
                    ),
                    studioName: "여기스튜디오1",
                    reservedDateTime: "2024-12-28",
                    orderItemDto: OrderItemEntity(itemId: 0, itemName: "프로필D", itemImage: "", quantity: 1, itemPrice: 20000, totalPrice: 20000, orderOptionDtos: []),
                    status: .finished,
                    studioImage: ""
                ),
            ]
            
            promise(.success(list))
        }
        .eraseToAnyPublisher()
    }
    
    func updateOrder(orderId: Int, order: UpdateOrderEntity) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, any Error> { promise in
            let success: Bool = false
            promise(.success(success))
        }
        .eraseToAnyPublisher()
    }
}
