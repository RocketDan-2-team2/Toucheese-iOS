//
//  ConceptView.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI
import Combine

struct ConceptView: View {
    let studioService: StudioService = DefaultStudioService()
    
    @EnvironmentObject private var navigationManger: NavigationManager
    @State private var bag = Set<AnyCancellable>()
    
    @State private var conceptList: [ConceptEntity] = []
    
    var body: some View {
        VStack(spacing: 0) {
            Text("터치즈 로고")
                .font (.title)
            
            ScrollView {
                LazyVGrid(
                    columns: [GridItem](
                        repeating: .init(.flexible()),
                        count: 2
                    ),
                    spacing: 16
                ) {
                    if conceptList.isEmpty {
                        ForEach(0..<6, id: \.self) { _ in
                            ConceptButton(
                                conceptImage: "",
                                conceptName: ""
                            )
                        }
                    } else {
                        ForEach(conceptList) { concept in
                            ConceptButton(
                                conceptImage: concept.image ?? "",
                                conceptName: concept.name
                            ) {
                                navigationManger.push(
                                    .studioListView(concept: concept)
                                )
                            }
                        }
                    }
                }
                .padding(10)
            }
            .scrollIndicators(.hidden)
        }
        .task {
            await fetchConceptList()
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
        ConceptView()
    }
}
