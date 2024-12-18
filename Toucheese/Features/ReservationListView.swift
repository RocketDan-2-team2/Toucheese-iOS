//
//  ReservationListView.swift
//  Toucheese
//
//  Created by 최주리 on 12/18/24.
//

import SwiftUI

struct ReservationListView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<5) { _ in
                    ReservationCell()
                }
                .padding(.top, 13)
            }
        }
        .navigationTitle("예약 일정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ReservationListView()
    }
}
