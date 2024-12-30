//
//  TestView.swift
//  Toucheese
//
//  Created by SunJoon Lee on 12/30/24.
//

import SwiftUI
import Combine

struct TestView: View {
    
    private let userService = DefaultUserService()
    
    @State private var bag = Set<AnyCancellable>()
    
    @State private var user: UserEntity
    
    init() {
        self.user = UserEntity(name: "이름", phone: "010", email: "sun@gmail")
    }
    
    var body: some View {
        VStack {
            Text(user.name)
            Text(user.phone)
            Text(user.email)
        }
        .onAppear {
            fetchUserDetail()
        }
    }
    
    func fetchUserDetail() {
        userService.detail()
            .sink { event in
                switch event {
                case .finished:
                    print(event)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { user in
                self.user = user.translate()
            }
            .store(in: &bag)
    }
    
}

#Preview {
    TestView()
}
