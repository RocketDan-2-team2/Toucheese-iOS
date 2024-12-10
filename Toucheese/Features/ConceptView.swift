//
//  ConceptView.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI

struct ConceptView: View {
    @State private var conceptList: [ConceptEntity]
    @State private var selectedConcept: ConceptEntity?
    
    init(conceptList: [ConceptEntity]) {
        self.conceptList = conceptList
    }
    
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
                    spacing: 12
                ) {
                    ForEach(conceptList) { concept in
                        ConceptButton(
                            conceptImage: concept.image ?? "",
                            conceptName: concept.name
                        ) {
                            selectedConcept = concept
                        }
                    }
                }
                .padding()
            }
            .scrollIndicators(.hidden)
        }
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(item: $selectedConcept) { concept in
            StudioListView(concept: concept)
        }
    }
}

#Preview {
    NavigationStack {
        IntroView()
    }
}
