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
                FilterButton(buttonType: .representation(hasFiltered: false))
                ForEach(FilterType.allCases, id: \.self) { filter in
                    FilterButton(buttonType: .filterType(title: filter.title))
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    StudioListView(concept: .init(id: 1, name: "VIBRANT", image: nil))
}
