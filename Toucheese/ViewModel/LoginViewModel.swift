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
    
    func requestKakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { _, error in
                if let error {
                    debugPrint(error.localizedDescription)
                } else {
                    UserApi.shared.me { user, _ in
                        guard let id = user?.id,
                              let email = user?.kakaoAccount?.email else { return }
                        debugPrint(id, email)
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { _, error in
                if let error {
                    debugPrint(error.localizedDescription)
                } else {
                    UserApi.shared.me { user, _ in
                        guard let id = user?.id,
                              let email = user?.kakaoAccount?.email else { return }
                        debugPrint(id, email)
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
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            guard let userID = result?.user.userID,
                  let email = result?.user.profile?.email,
                  let name = result?.user.profile?.name else { return }
            debugPrint(userID, email, name)
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
        guard let email = credential.email,
              let name = credential.fullName else { return }
        debugPrint(credential.user, email, name)
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
