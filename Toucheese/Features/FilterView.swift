//
//  FilterView.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import SwiftUI

struct FilterView: View {
    
    @Binding var isChanged: Bool
    @Binding var isHidden: Bool
    
    @Binding var selectedFilterType: FilterType?
    
    @Binding var selectedRegion: RegionType?
    @Binding var selectedRating: RatingType?
    @Binding var selectedPrice: PriceType?
    
    var body: some View {
        VStack {
            HStack {
                if isChanged {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 18))
                        .padding(.trailing, 10)
                        .onTapGesture {
                            selectedRegion = nil
                            selectedRating = nil
                            selectedPrice = nil
                            selectedFilterType = nil
                            isChanged.toggle()
                            isHidden = true
                        }
                }
                ForEach(FilterType.allCases, id: \.self) { filter in
                    FilterButton(filterName: "\(filter.title)", isSelected: selectedFilterType == filter) {
                        if isHidden || selectedFilterType == nil {
                            selectedFilterType = filter
                            isHidden.toggle()
                        } else if selectedFilterType != filter {
                            selectedFilterType = filter
                        } else {
                            isHidden = true
                            selectedFilterType = nil
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    StudioListView()
}
