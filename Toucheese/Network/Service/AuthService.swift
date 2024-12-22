//
//  AuthService.swift
//  Toucheese
//
//  Created by 유지호 on 12/21/24.
//

import Foundation
import Moya
import Combine

protocol AuthService {
    func signIn(_ socialType: SocialType, id: String, email: String?, name: String?) -> AnyPublisher<SignInResultEntity, Error>
}

final class DefaultAuthService: BaseService<AuthAPI> { }

extension DefaultAuthService: AuthService {
    
    func signIn(
        _ socialType: SocialType,
        id: String,
        email: String?,
        name: String?
    ) -> AnyPublisher<SignInResultEntity, any Error> {
        requestObjectWithNetworkError(.signIn(
            parameters: ["socialProvider": socialType.rawValue,
                         "socialId": id,
                         "email": email,
                         "username": name]
        ))
    }

}
