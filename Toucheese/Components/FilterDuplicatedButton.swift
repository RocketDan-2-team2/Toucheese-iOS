//
//  FilterDuplicatedButton.swift
//  Toucheese
//
//  Created by 최주리 on 11/27/24.
//

import SwiftUI

struct FilterDuplicatedButton<T: FilterProtocol>: View {
    
    let type: T?
    @Binding var selectedType: [T]
    
    let filterAction: (() -> Void)?
    
    var isSelected: Bool {
        guard let type else {
            if selectedType.count == 0 {
                return true
            } else {
                return false
            }
        }
        return selectedType.contains(type)
    }
    
    
    init(
        type: T? = nil,
        selectedType: Binding<[T]>,
        filterAction: (() -> Void)? = nil
        
    ) {
        self.type = type
        self._selectedType = selectedType
        self.filterAction = filterAction
    }
    
    var body: some View {
        Button {
            
            if let type {
                if isSelected {
                    let index = selectedType.firstIndex(where: { $0 == type })!
                    selectedType.remove(at: index)
                } else {
                    selectedType.append(type)
                }
            } else {
                selectedType.removeAll()
                return
            }
            
            filterAction?()
        } label: {
            VStack(alignment: .center) {
                if let type {
                    Text("\(type.title)")
                } else {
                    Text("전체")
                }
                    
                Image(systemName: isSelected ? "square.fill" : "square")
            }
            .font(.system(size: 14))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
