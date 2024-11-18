//
//  FilterView.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import SwiftUI

struct FilterView: View {

    @State var isChanged: Bool = false
    @State var isHidden: Bool = true
    
    @State var selectedFilterType: FilterType?
    
    @State var selectedRegion: RegionType? = nil
    @State var selectedRating: RatingType? = nil
    @State var selectedPrice: PriceType? = nil
    
    var body: some View {
        ZStack {
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
                
                HStack {
                    switch selectedFilterType {
                    case .region:
                        FilterRadioButton(type: nil, selectedType: $selectedRegion) {
                            selectedRegion = nil
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
            }
        }
        .frame(maxWidth: .infinity)
        .background(isHidden ? .orange.opacity(0) : .orange.opacity(0.05))
    }
}

#Preview {
    FilterView()
}
