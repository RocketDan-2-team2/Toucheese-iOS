//
//  ConceptView.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI

struct ConceptView: View {
    @State private var conceptList: [String] = [
        "생동감 있는",
        "플래쉬/유광",
        "선명한",
        "수체화 그림체"
    ]
    
    var body: some View {
        VStack {
            Text("터치즈 로고")
                .font(.title)
            
            Spacer()
            
            LazyVGrid(columns: [GridItem](
                repeating: .init(.flexible()),
                count: 2
            )) {
                ForEach(conceptList.indices, id: \.self) { index in
                    ConceptButton(
                        conceptImage: "",
                        conceptName: conceptList[index]
                    ) {
                        print(conceptList[index])
                    }
                }
            }
            
            Spacer()
        }
        .padding(12)
    }
}

#Preview {
    ConceptView()
}
