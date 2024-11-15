//
//  FilterView.swift
//  Toucheese
//
//  Created by 최주리 on 11/15/24.
//

import SwiftUI

struct FilterView: View {
    
    @State var isChanged: Bool = true
    
    var body: some View {
            
        HStack {
            if isChanged {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 18))
                    .padding(.trailing, 10)
            }
            ForEach(FilterType.allCases, id: \.self) { filter in
                FilterButton(filterName: "\(filter.rawValue)")
            }
        }
    }
}

#Preview {
    FilterView()
}
