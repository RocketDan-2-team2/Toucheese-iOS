//
//  ConceptButton.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI
import SkeletonUI

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
                RoundedRectangle(cornerRadius: 20)
                    .fill(.clear)
                    .aspectRatio(9 / 11, contentMode: .fit)
                    .overlay {
                        AsyncImage(url: URL(string: conceptImage)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                            default:
                                Rectangle()
                                    .fill(.clear)
                                    .skeleton(
                                        with: true,
                                        appearance: .gradient(
                                            color: Color(uiColor: .lightGray).opacity(0.5),
                                            background: .clear
                                        ),
                                        shape: .rectangle
                                    )
                            }
                        }
                    }
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(
                        color: .black.opacity(0.1),
                        radius: 8,
                        y: 2
                    )
                
                Text(conceptName)
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.vertical, 4)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ConceptButton(conceptImage: "", conceptName: "컨셉 이름")
}
