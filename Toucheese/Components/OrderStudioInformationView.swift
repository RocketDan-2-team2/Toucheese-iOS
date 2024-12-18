//
//  OrderStudioInformationView.swift
//  Toucheese
//
//  Created by 최주리 on 12/18/24.
//

import SwiftUI

struct OrderStudioInformationView: View {
    let studio: StudioInfo
    let selectedDateString: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(studio.name)")
                .font(.system(size: 16, weight: .bold))
            Text(selectedDateString)
                .font(.system(size: 16, weight: .medium))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.gray01, in: RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray02)
        }
    }
}
