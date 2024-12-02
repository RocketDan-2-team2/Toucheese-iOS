//
//  FilterExpansionView.swift
//  Toucheese
//
//  Created by SunJoon Lee on 11/18/24.
//

import SwiftUI

struct FilterExpansionView: View {
    
    @ObservedObject var studioViewModel: StudioViewModel
    @Binding var selectedFilterType: FilterType?
    
    var body: some View {
        HStack {
            switch selectedFilterType {
            case .region:
                FilterDuplicatedButton(type: nil, selectedType: $studioViewModel.selectedRegion) {
                    studioViewModel.selectedRegion = []
                }
                ForEach(RegionType.allCases, id:
                            \.self) { type in
                    FilterDuplicatedButton(type: type, selectedType: $studioViewModel.selectedRegion)
                }
            case .rating:
                FilterRadioButton(type: nil, selectedType: $studioViewModel.selectedRating) {
                    studioViewModel.selectedRating = nil
                }
                ForEach(RatingType.allCases, id:
                            \.self) { type in
                    FilterRadioButton(type: type, selectedType: $studioViewModel.selectedRating)
                }
            case .price:
                FilterRadioButton(type: nil, selectedType: $studioViewModel.selectedPrice) {
                    studioViewModel.selectedPrice = nil
                }
                ForEach(PriceType.allCases, id:
                            \.self) { type in
                    FilterRadioButton(type: type, selectedType: $studioViewModel.selectedPrice)
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
