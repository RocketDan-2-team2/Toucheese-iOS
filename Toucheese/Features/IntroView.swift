//
//  IntroView.swift
//  Toucheese
//
//  Created by 유지호 on 12/6/24.
//

import SwiftUI
import Combine

struct IntroView: View {
    let studioService: StudioService = DefaultStudioService()
    
    @State private var conceptList: [ConceptEntity]?
    @State private var bag = Set<AnyCancellable>()
    
    var body: some View {
        Spacer()
            .navigationDestination(item: $conceptList) { conceptList in
                ConceptView(conceptList: conceptList)
            }
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
                self.conceptList = conceptList
            }
            .store(in: &bag)
    }
}

#Preview {
    NavigationStack {
        IntroView()
    }
}
