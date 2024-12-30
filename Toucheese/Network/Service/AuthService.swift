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
    func reissuance() -> AnyPublisher<AuthTokenEntity, Error>
    func reissuance(completion: @escaping (Bool) -> Void)
    func nicknameCheck(_ nickname: String) -> AnyPublisher<Bool, Error>
    func profileUpdate(name: String?, nickname: String?, email: String?, phone: String?) -> AnyPublisher<Bool, Error>
}

final class DefaultAuthService: BaseService<AuthAPI> { }

extension DefaultAuthService: AuthService {
    
    func signIn(
        _ socialType: SocialType,
        id: String,
        email: String?,
        name: String?
    ) -> AnyPublisher<SignInResultEntity, Error> {
        requestObjectWithNetworkError(.signIn(
            parameters: ["socialProvider": socialType.rawValue,
                         "socialId": id,
                         "email": email,
                         "username": name]
        ))
    }
    
    func reissuance() -> AnyPublisher<AuthTokenEntity, Error> {
        requestObjectWithNetworkError(.reissuance)
    }
    
    func reissuance(completion: @escaping (Bool) -> Void) {
        provider.request(.reissuance) { result in
            switch result {
            case .success(let value):
                do {
                    let body = try JSONDecoder().decode(AuthTokenEntity.self, from: value.data)
                    UserDefaultsKey.Auth.accessToken = body.accessToken
                    UserDefaultsKey.Auth.refreshToken = body.refreshToken
                    completion(true)
                } catch {
                    completion(false)
                }
            case .failure:
                completion(false)
            }
        }
    }
    
    func nicknameCheck(_ nickname: String) -> AnyPublisher<Bool, Error> {
        requestObjectWithNetworkError(.nicknameCheck(
            parameters: ["nickname": nickname]
        ))
    }
    
    func profileUpdate(
        name: String?,
        nickname: String?,
        email: String?,
        phone: String?
    ) -> AnyPublisher<Bool, Error> {
        requestObjectWithNetworkError(.profileUpdate(
            parameters: ["username": name,
                         "nickname": nickname,
                         "email": email,
                         "phone": phone]
        ))
    }

}
