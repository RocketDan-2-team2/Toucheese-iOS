//
//  FilterView.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import SwiftUI

struct FilterView: View {

    @Binding var selectedFilterType: FilterType?
    
    @Binding var selectedRegion: RegionType?
    @Binding var selectedRating: RatingType?
    @Binding var selectedPrice: PriceType?
    
    private var isChanged: Bool {
        !(selectedPrice == nil && selectedRating == nil && selectedRegion == nil)
    }
    
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
    StudioListView()
}
