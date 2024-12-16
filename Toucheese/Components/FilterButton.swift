//
//  FilterButton.swift
//  Toucheese
//
//  Created by 최주리 on 11/14/24.
//

import SwiftUI

struct FilterButton: View {
    
    let buttonType: FilterButtonType
    let filterAction: (() -> Void)?
    
    init(
        buttonType: FilterButtonType = .representation(hadFiltered: false),
        filterAction: (() -> Void)? = nil
    ) {
        self.buttonType = buttonType
        self.filterAction = filterAction
    }
    
    var body: some View {
        Button {
            filterAction?()
        } label: {
            HStack {
                if case .representation(_) = buttonType {
                    Image(systemName: buttonType.iconString)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.gray06)
                }
                
                Text(buttonType.description)
                    .foregroundStyle(Color.gray09)
                    
                if case .filterType(_) = buttonType {
                    Image(systemName: buttonType.iconString)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.gray06)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .fill(Color.gray01)
                        .strokeBorder(Color.gray02)
                }
            }
            .overlay(alignment: .topTrailing) {
                HStack {
                    if case .representation(let hasFiltered) = buttonType {
                        if hasFiltered {
                            Circle()
                                .fill(Color.primary06)
                                .frame(width: 4.0, height: 4.0, alignment: .topLeading)
                        }
                    }
                }
                .padding(8.0)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    
    enum FilterButtonType: Equatable {
        case representation(hadFiltered: Bool)
        case filterType(title: String)
        
        var description: String {
            switch self {
            case .representation(_):
                "필터"
            case .filterType(let title):
                title
            }
        }
        
        var iconString: String {
            switch self {
            case .representation(_):
                "text.alignleft"
//                "text.justify.left"
            case .filterType(_):
                "chevron.down"
            }
        }
    }
}

#Preview {
    VStack {
        FilterButton(buttonType: .representation(hadFiltered: true))
        FilterButton(buttonType: .representation(hadFiltered: false))
        FilterButton(buttonType: .filterType(title: "지역"))
        FilterButton(buttonType: .filterType(title: "가격"))
        FilterButton(buttonType: .filterType(title: "인기"))
    }
}
