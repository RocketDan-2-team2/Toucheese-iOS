//
//  FilterExpansionView.swift
//  Toucheese
//
//  Created by SunJoon Lee on 11/18/24.
//

import SwiftUI

struct FilterExpansionView: View {
    @Binding var isChanged: Bool
    @Binding var isHidden: Bool
    
    @Binding var selectedFilterType: FilterType?
    
    @Binding var selectedRegion: RegionType?
    @Binding var selectedRating: RatingType?
    @Binding var selectedPrice: PriceType?
    
    var body: some View {
        HStack {
            switch selectedFilterType {
            case .region:
                FilterRadioButton(type: nil, selectedType: $selectedRegion) {
                    selectedRegion = nil
                    if selectedPrice == nil && selectedRating == nil && selectedRegion == nil {
                        isChanged = false
                    }
                }
                ForEach(RegionType.allCases, id:
                            \.self) { type in
                    FilterRadioButton(type: type, selectedType: $selectedRegion) {
                        isChanged = true
                    }
                }
            case .rating:
                FilterRadioButton<RatingType>(type: nil, selectedType: $selectedRating) {
                    selectedRating = nil
                    if selectedPrice == nil && selectedRating == nil && selectedRegion == nil {
                        isChanged = false
                    }
                }
                ForEach(RatingType.allCases, id:
                            \.self) { type in
                    FilterRadioButton(type: type, selectedType: $selectedRating) {
                        isChanged = true
                    }
                }
            case .price:
                FilterRadioButton<PriceType>(type: nil, selectedType: $selectedPrice) {
                    selectedPrice = nil
                    if selectedPrice == nil && selectedRating == nil && selectedRegion == nil {
                        isChanged = false
                    }
                }
                ForEach(PriceType.allCases, id:
                            \.self) { type in
                    FilterRadioButton(type: type, selectedType: $selectedPrice) {
                        isChanged = true
                    }
                }
            case nil:
                Spacer()
                    .padding()
            }
        }
        .padding(.vertical, 30)
        .opacity(isHidden ? 0 : 1)
        .frame(maxWidth: .infinity)
        .background(isHidden ? .orange.opacity(0) : .yellow)
        .clipShape(.rect(cornerRadius: 20))
        .shadow(radius: 5)
    }
}

#Preview {
    FilterView()
}
