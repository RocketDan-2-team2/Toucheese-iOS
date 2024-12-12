//
//  ConceptView.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI

struct ConceptView: View {
    
    @EnvironmentObject private var navigationManger: NavigationManager
    
    @State private var conceptList: [ConceptEntity]
    
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
                            navigationManger.path.append(
                                .studioListView(concept: concept)
                            )
                        }
                    }
                }
                .padding()
            }
            .scrollIndicators(.hidden)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        IntroView()
    }
}
