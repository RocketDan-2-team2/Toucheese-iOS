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
    
    @State private var conceptList: [ConceptEntity] = []
    
    @State private var selectedConcept: ConceptEntity?
    
    // MARK: 임시 상태 관리 CancellableBag - 추후 ViewModel로 분리 예정
    @State private var bag = Set<AnyCancellable>()
    
    var body: some View {
        VStack {
            Text("터치즈 로고")
                .font(.title)
            
            Spacer()
            
            LazyVGrid(columns: [GridItem](
                repeating: .init(.flexible()),
                count: 2
            )) {
                ForEach(conceptList) { concept in
                    ConceptButton(
                        conceptImage: concept.image ?? "",
                        conceptName: concept.name
                    ) {
                        selectedConcept = concept
                    }
                    .aspectRatio(1, contentMode: .fill)
                }
            }
            
            Spacer()
        }
        .padding(12)
        .task {
            if !conceptList.isEmpty { return }
            fetchConceptList()
        }
        .navigationDestination(item: $selectedConcept) { concept in
            StudioListView()
        }
    }
    
    func fetchConceptList() {
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
