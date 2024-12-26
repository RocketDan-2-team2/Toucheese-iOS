//
//  LoginViewModel.swift
//  Toucheese
//
//  Created by 유지호 on 12/20/24.
//

import Foundation
import Combine
import KakaoSDKUser
import GoogleSignIn
import AuthenticationServices
import CryptoKit

class LoginViewModel: NSObject, ObservableObject {
    
    private let authService: AuthService = DefaultAuthService()
    private var bag = Set<AnyCancellable>()
    
    func requestSignIn(_ socialType: SocialType, id: String, email: String?, name: String?) {
        authService.signIn(socialType, id: id, email: email, name: name)
            .sink { event in
                switch event {
                case .finished:
                    print("SignIn: \(event)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { result in
                // TODO: statusCode에 따라 첫 로그인 시도인지 아닌지 판별
                // - 첫 로그인 시도면 회원가입 플로우
                // - 두번째 이상 시도면 로그인 처리
                debugPrint(result)
            }
            .store(in: &bag)
    }
    
    func requestKakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { _, error in
                if let error {
                    debugPrint(error.localizedDescription)
                } else {
                    UserApi.shared.me { [weak self] user, _ in
                        guard let id = user?.id,
                              let email = user?.kakaoAccount?.email else { return }
                        self?.requestSignIn(.kakao, id: "\(id)", email: email, name: nil)
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { _, error in
                if let error {
                    debugPrint(error.localizedDescription)
                } else {
                    UserApi.shared.me { [weak self] user, _ in
                        guard let id = user?.id,
                              let email = user?.kakaoAccount?.email else { return }
                        self?.requestSignIn(.kakao, id: "\(id)", email: email, name: nil)
                    }
                }
            }
        }
    }
    
    func requestGoogleLogin() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController
        else {
            print("There is no root view controller!")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            guard let id = result?.user.userID,
                  let email = result?.user.profile?.email,
                  let name = result?.user.profile?.name else { return }
            self?.requestSignIn(.google, id: id, email: email, name: name)
        }
    }
    
    func requestAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
}

extension LoginViewModel: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        
        // 애플 로그인의 경우 첫 인증 시에만 유저 정보를 제공하고 이후에는 credential만 보내줌 (보안 이슈)
//        let isHideEmail = email.contains("privaterelay.appleid")
        requestSignIn(
            .apple,
            id: credential.user,
            email: credential.email,
            name: credential.fullName?.formatted()
        )
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: any Error
    ) {
        debugPrint(error.localizedDescription)
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first
        else { fatalError("There is no Window") }
        
        return window
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        
        if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        let nonce = randomBytes.map { charset[Int($0) % charset.count] }
        
        return String(nonce)
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap { String(format: "%02x", $0) }.joined()
        
        return hashString
    }
    
}
