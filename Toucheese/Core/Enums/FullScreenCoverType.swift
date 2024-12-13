//
//  FullScreenCoverType.swift
//  Toucheese
//
//  Created by 최주리 on 12/13/24.
//

import SwiftUI

enum FullScreenCoverType: Identifiable {
    case reviewPhotoDetailView(imageList: [String], selectedPhotoIndex: Binding<Int>)

    var id: String {
        "\(self)"
    }
}
