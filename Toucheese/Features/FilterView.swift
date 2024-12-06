//
//  FilterView.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import SwiftUI

struct FilterView: View {
    
    @ObservedObject var studioViewModel: StudioViewModel
    @Binding var selectedFilterType: FilterType?
    
    private var isChanged: Bool {
        !(studioViewModel.selectedPrice == nil && studioViewModel.selectedRating == nil && studioViewModel.selectedRegion.count == 0)
    }
    
    var body: some View {
        VStack {
            HStack {
                if isChanged {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 18))
                        .padding(.horizontal, 20)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            studioViewModel.selectedRegion = []
                            studioViewModel.selectedRating = nil
                            studioViewModel.selectedPrice = nil
                            selectedFilterType = nil
                        }
                }
                ForEach(FilterType.allCases, id: \.self) { filter in
                    FilterButton(filterName: "\(filter.title)", isSelected: selectedFilterType == filter) {
                        if selectedFilterType == nil || selectedFilterType != filter {
                            selectedFilterType = filter
                        } else {
                            selectedFilterType = nil
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
//        .border(.black)
    }
}

#Preview {
    StudioListView(concept: .init(id: 1, name: "VIBRANT", image: nil))
}
