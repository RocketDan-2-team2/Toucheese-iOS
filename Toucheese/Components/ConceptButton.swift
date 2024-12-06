//
//  ConceptButton.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI

struct ConceptButton: View {
    let conceptImage: String
    let conceptName: String
    
    let tapAction: (() -> Void)?
    
    init(
        conceptImage: String,
        conceptName: String,
        tapAction: (() -> Void)? = nil
    ) {
        self.conceptImage = conceptImage
        self.conceptName = conceptName
        self.tapAction = tapAction
    }
    
    var body: some View {
        Button {
            tapAction?()
        } label: {
            VStack(spacing: 0) {
                AsyncImage(url: URL(string: conceptImage)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Rectangle()
                        .fill(.placeholder)
                        .overlay {
                            ProgressView()
                        }
                }
                .aspectRatio(9 / 11, contentMode: .fill)
                
                Text(conceptName)
                    .font(.system(size: 12))
                    .padding(.vertical, 4)
            }
            .background(.placeholder)
            .clipShape(.rect(cornerRadius: 20))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ConceptButton(conceptImage: "", conceptName: "컨셉 이름")
}
