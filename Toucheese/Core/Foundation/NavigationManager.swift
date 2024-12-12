//
//  NavigationManager.swift
//  Toucheese
//
//  Created by 최주리 on 12/12/24.
//

import SwiftUI

final class NavigationManager: ObservableObject {
    @Published var path: [ViewType] = []
}
