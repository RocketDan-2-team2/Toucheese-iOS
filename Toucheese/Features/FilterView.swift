//
//  FilterView.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import SwiftUI

struct FilterView: View {
    // 임시
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
                    }
                    ForEach(FilterType.allCases, id: \.self) { filter in
                        FilterButton(filterName: "\(filter.title)") {
                            if isHidden || selectedFilterType == nil {
                                selectedFilterType = filter
                                isHidden.toggle()
                            } else if selectedFilterType != filter {
                                selectedFilterType = filter
                            } else {
                                isHidden = true
                            }
                        }
                    }
                }
                
                HStack {
                    switch selectedFilterType {
                    case .region:
                        FilterRadioButton(type: nil, selectedType: $selectedRegion) {
                            selectedRegion = nil
//                            isHidden = true
                        }
                        ForEach(RegionType.allCases, id:
                                    \.self) { type in
                            FilterRadioButton(type: type, selectedType: $selectedRegion)
                        }
                    case .rating:
                        FilterRadioButton<RatingType>(type: nil, selectedType: $selectedRating) {
                            selectedRating = nil
//                            isHidden = true
                        }
                        ForEach(RatingType.allCases, id:
                                    \.self) { type in
                            FilterRadioButton(type: type, selectedType: $selectedRating)
                        }
                    case .price:
                        FilterRadioButton<PriceType>(type: nil, selectedType: $selectedPrice) {
                            selectedPrice = nil
//                            isHidden = true
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
