//
//  FilterExpansionView.swift
//  Toucheese
//
//  Created by SunJoon Lee on 11/18/24.
//

import SwiftUI

struct FilterExpansionView: View {
    
    @EnvironmentObject private var navigationManager: NavigationManager
    
    @ObservedObject var studioViewModel: StudioViewModel

    var initialFilter: (region: [RegionType], rating: RatingType?, price: PriceType?)
    
    init(studioViewModel: StudioViewModel) {
        self.studioViewModel = studioViewModel
        self.initialFilter = (studioViewModel.selectedRegion, studioViewModel.selectedRating, studioViewModel.selectedPrice)
    }
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 16.0) {
            HStack {
                Text("필터")
                    .font(.system(size: 16.0))
                    .bold()
                Spacer()
                Image(systemName: "xmark")
                    .bold()
                    .onTapGesture {
                        studioViewModel.selectedRegion = initialFilter.region
                        studioViewModel.selectedPrice = initialFilter.price
                        studioViewModel.selectedRating = initialFilter.rating
                        
                        navigationManager.dismiss()
                    }
            }
            
            VStack(alignment: .leading) {
                Text("지역")
                    .font(.system(size: 14.0))
                    .padding(.vertical, 11.5)
                
                LazyVGrid(columns: columns, spacing: 16.0) {
                    // 지역 전체 버튼
                    HStack {
                        FilterDuplicatedButton(
                            type: nil,
                            selectedType: $studioViewModel.selectedRegion
                        )
                        Spacer()
                    }
                    // 지역 allCases
                    ForEach(RegionType.allCases, id: \.self) { region in
                        HStack {
                            FilterDuplicatedButton(
                                type: region,
                                selectedType: $studioViewModel.selectedRegion
                            )
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
                
                // 인기 전체 버튼
                HStack {
                    FilterRadioButton(
                        type: nil,
                        selectedType: $studioViewModel.selectedRating
                    )
                    Spacer()
                }
                // 인기 allCases
                ForEach(RatingType.allCases, id: \.self) { rating in
                    HStack {
                        FilterRadioButton(
                            type: rating,
                            selectedType: $studioViewModel.selectedRating
                        )
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
                
                // 가격 전체 버튼
                HStack {
                    FilterRadioButton(
                        type: nil,
                        selectedType: $studioViewModel.selectedPrice
                    )
                    Spacer()
                }
                // 가격 allCases
                ForEach(PriceType.allCases, id: \.self) { price in
                    HStack {
                        FilterRadioButton(
                            type: price,
                            selectedType: $studioViewModel.selectedPrice
                        )
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
                        style: .mediumGray,
                        padding: (vertical: 11.5, horizontal: 21.5)
                    )
                    .onTapGesture {
                        studioViewModel.selectedRegion.removeAll()
                        studioViewModel.selectedRating = nil
                        studioViewModel.selectedPrice = nil
                        
                        // API 호출
                        studioViewModel.searchStudioWithDefaultPage()
                    }
                Text("n개의 스튜디오 보기")
                    .font(.system(size: 14.0))
                    .bold()
                    .toucheeseButtonStyle(
                        shapeStyle: .fullWidth
                    )
                    .onTapGesture {
                        // API 호출
                        studioViewModel.searchStudioWithDefaultPage()
                        
                        navigationManager.dismiss()
                    }
            }
        }
        .padding([.top, .horizontal], 24.0)
    }
}

#Preview {
    FilterExpansionView(
        studioViewModel: StudioViewModel()
    )
}
