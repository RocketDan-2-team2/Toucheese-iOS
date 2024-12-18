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
        ZStack {
            VStack {
                HStack {
                    FilterButton(buttonType: .representation(hadFiltered: false))
                    ForEach(FilterType.allCases, id: \.self) { filter in
                        FilterButton(buttonType: .filterType(title: filter.title))
                    }
                    Spacer()
                }
                Rectangle()
            }
            
            HStack {
                Spacer()
                
                FilterDrawerView(
                    regionSelection: .constant([]),
                    ratingSelection: .constant(.first),
                    priceSelection: .constant(.first)
                )
                .containerRelativeFrame(.horizontal, alignment: .trailing) { length, _ in
                    length * (4 / 5)
                }
            }
        }
    }
}

struct FilterDrawerView: View {
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @Binding var regionSelection: [RegionType]
    @Binding var ratingSelection: RatingType?
    @Binding var priceSelection: PriceType?
    
    var body: some View {
        ZStack {
            UnevenRoundedRectangle(topLeadingRadius: 8.0)
                .fill(.background)
            
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
                    
                    LazyVGrid(columns: columns, spacing: 16.0) {
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
                
                VStack(alignment: .leading, spacing: 16.0) {
                    Text("인기")
                        .font(.system(size: 14.0))
                    
                    ForEach(RatingType.allCases, id: \.self) { rating in
                        HStack {
                            FilterRadioButton(type: rating, selectedType: $ratingSelection)
                            Spacer()
                        }
                    }
                }
                
                Divider()
                    .padding(.top, 16.0)
                
                VStack(alignment: .leading, spacing: 16.0) {
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
                
                HStack(spacing: 8.0) {
                    Text("초기화")
                        .font(.system(size: 14.0))
                        .bold()
                        .toucheeseButtonStyle(
                            style: .medium,
                            padding: (vertical: 11.5, horizontal: 21.5)
                        )
                    Text("n개의 스튜디오 보기")
                        .font(.system(size: 14.0))
                        .bold()
                        .toucheeseButtonStyle(
                            shapeStyle: .fullWidth
                        )
                }
            }
            .padding([.top, .horizontal], 24.0)
        }
    }
}

#Preview {
    FilterView(studioViewModel: StudioViewModel(), selectedFilterType: .constant(.price))
}
