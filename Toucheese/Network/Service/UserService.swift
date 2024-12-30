//
//  UserService.swift
//  Toucheese
//
//  Created by SunJoon Lee on 12/30/24.
//

import Foundation
import Moya
import Combine

protocol UserService {
    func detail() -> AnyPublisher<UserDetailEntity, Error>
}

final class DefaultUserService: BaseService<UserAPI> { }

extension DefaultUserService: UserService {
    
    func detail() -> AnyPublisher<UserDetailEntity, Error> {
        requestObjectWithNetworkError(.detail)
    }
}