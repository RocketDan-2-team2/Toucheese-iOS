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
    
    var tapAction: (() -> Void)?
    
    var body: some View {
        Button {
            tapAction?()
        } label: {
            VStack(spacing: 2) {
                AsyncImage(url: URL(string: conceptImage)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    default:
                        Color.clear
                            .skeleton(
                                with: true,
                                appearance: .gradient(
                                    color: Color(uiColor: .lightGray).opacity(0.5),
                                    background: Color(uiColor: .lightGray).opacity(0.3)
                                ),
                                shape: .rectangle
                            )
                    }
                }
                .aspectRatio(9 / 11, contentMode: .fit)
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
        .buttonStyle(.plain)
    }
}

#Preview {
    ConceptButton(conceptImage: "", conceptName: "컨셉 이름")
}
