//
//  IntroView.swift
//  Toucheese
//
//  Created by 유지호 on 12/6/24.
//

import SwiftUI
import Combine

struct IntroView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    let studioService: StudioService = DefaultStudioService()
    
    @State private var bag = Set<AnyCancellable>()
    
    var body: some View {
        Spacer()
            .task {
                await fetchConceptList()
            }
            .onAppear {
                UINavigationBar.setAnimationsEnabled(false)
            }
            .onDisappear {
                UINavigationBar.setAnimationsEnabled(true)
            }
    }
    
    func fetchConceptList() async {
        try? await Task.sleep(for: .seconds(1))
        
        studioService.getStudioConceptList()
            .sink { event in
                switch event {
                case .finished:
                    print("Concept: \(event)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { conceptList in
                navigationManager.path.append(
                    .conceptView(conceptList: conceptList)
                )
            }
            .store(in: &bag)
    }
}

#Preview {
    NavigationStack {
        IntroView()
    }
}
