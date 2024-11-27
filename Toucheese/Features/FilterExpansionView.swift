//
//  FilterExpansionView.swift
//  Toucheese
//
//  Created by SunJoon Lee on 11/18/24.
//

import SwiftUI

struct FilterExpansionView: View {
    
    @Binding var selectedFilterType: FilterType?
    
    @Binding var selectedRegion: [RegionType]
    @Binding var selectedRating: RatingType?
    @Binding var selectedPrice: PriceType?
    
    var body: some View {
        HStack {
            switch selectedFilterType {
            case .region:
                FilterDuplicatedButton(type: nil, selectedType: $selectedRegion) {
                    selectedRegion = []
                }
                ForEach(RegionType.allCases, id:
                            \.self) { type in
                    FilterDuplicatedButton(type: type, selectedType: $selectedRegion)
                }
            case .rating:
                FilterRadioButton(type: nil, selectedType: $selectedRating) {
                    selectedRating = nil
                }
                ForEach(RatingType.allCases, id:
                            \.self) { type in
                    FilterRadioButton(type: type, selectedType: $selectedRating)
                }
            case .price:
                FilterRadioButton(type: nil, selectedType: $selectedPrice) {
                    selectedPrice = nil
                }
                ForEach(PriceType.allCases, id:
                            \.self) { type in
                    FilterRadioButton(type: type, selectedType: $selectedPrice)
                }
            case nil:
                Spacer()
                    .padding()
            }
        }
        .padding(.vertical, 30)
        .frame(maxWidth: .infinity)
        .clipShape(.rect(cornerRadius: 20))
        .shadow(radius: 5)
    }
}

#Preview {
    StudioListView(concept: .init(id: 1, name: "VIBRANT", image: nil))
}
