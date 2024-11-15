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
                        FilterButton(filterName: "\(filter.title)")
                    }
                }   
                Text("dd")
                    .padding(.vertical, 50)
            }
        }
        .frame(maxWidth: .infinity)
        .background(.orange.opacity(0.05))
    }
}

#Preview {
    FilterView()
}
