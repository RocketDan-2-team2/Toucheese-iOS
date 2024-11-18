//
//  StudioListView.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI

struct StudioListView: View {
    
    @State private var isChanged: Bool = false
    @State private var isHidden: Bool = true
    
    @State private var selectedFilterType: FilterType?
    
    @State private var selectedRegion: RegionType? = nil
    @State private var selectedRating: RatingType? = nil
    @State private var selectedPrice: PriceType? = nil
    
    var body: some View {
        VStack {
            FilterView(
                isChanged: $isChanged,
                isHidden: $isHidden,
                selectedFilterType: $selectedFilterType,
                selectedRegion: $selectedRegion,
                selectedRating: $selectedRating,
                selectedPrice: $selectedPrice
            )
            FilterExpansionView(
                isChanged: $isChanged,
                isHidden: $isHidden,
                selectedFilterType: $selectedFilterType,
                selectedRegion: $selectedRegion,
                selectedRating: $selectedRating,
                selectedPrice: $selectedPrice
            )
        }
    }
}

#Preview {
    StudioListView()
}
