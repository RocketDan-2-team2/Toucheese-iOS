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
                FilterButton(buttonType: .representation(hadFiltered: false))
                ForEach(FilterType.allCases, id: \.self) { filter in
                    FilterButton(buttonType: .filterType(title: filter.title))
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct FilterDrawerView: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @Binding var regionSelection: [RegionType]
    @Binding var ratingSelection: RatingType?
    @Binding var priceSelection: PriceType?
    
    var body: some View {
        VStack(spacing: 16.0) {
            HStack {
                Text("필터")
                    .font(.system(size: 16.0))
                    .bold()
                Spacer()
                Image(systemName: "xmark")
                    .bold()
            }
            
            VStack(alignment: .leading) {
                Text("지역")
                    .font(.system(size: 14.0))
                    .padding(.vertical, 11.5)
                
                LazyVGrid(columns: columns) {
                    ForEach(RegionType.allCases, id: \.self) { region in
                        HStack {
                            FilterDuplicatedButton(type: region, selectedType: $regionSelection)
                            Spacer()
                        }
                    }
                }
            }
            
            Divider()
                .padding(.top, 16.0)
            
            VStack(alignment: .leading) {
                Text("인기")
                    .font(.system(size: 14.0))
                    .padding(.vertical, 11.5)
                
                ForEach(RatingType.allCases, id: \.self) { rating in
                    HStack {
                        FilterRadioButton(type: rating, selectedType: $ratingSelection)
                        Spacer()
                    }
                }
            }
            
            Divider()
                .padding(.top, 16.0)
            
            VStack(alignment: .leading) {
                Text("가격")
                    .font(.system(size: 14.0))
                    .padding(.vertical, 11.5)
                
                ForEach(PriceType.allCases, id: \.self) { price in
                    HStack {
                        FilterRadioButton(type: price, selectedType: $priceSelection)
                        Spacer()
                    }
                }
            }
            
            Spacer()
        }
        .padding(24.0)
    }
}

#Preview {
//    StudioListView(concept: .init(id: 1, name: "VIBRANT", image: nil))
    FilterDrawerView(
        regionSelection: .constant([]),
        ratingSelection: .constant(.first),
        priceSelection: .constant(.first)
    )
}
