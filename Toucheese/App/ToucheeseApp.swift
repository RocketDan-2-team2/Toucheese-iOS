//
//  ToucheeseApp.swift
//  Toucheese
//
//  Created by 유지호 on 11/14/24.
//

import SwiftUI

@main
struct ToucheeseApp: App {
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.path) {
                IntroView()
                    .navigationDestination(for: ViewType.self) { view in
                        switch view {
                        case .conceptView(let concepList):
                            ConceptView(conceptList: concepList)
                        case .studioListView(let concept):
                            StudioListView(concept: concept)
                        case .studioDetailView(let id):
                            StudioDetailView(studioId: id)
                        case .studioProductDetailView(let studio, let product):
                            StudioProductDetailView(studio: studio, product: product)
                        case .reviewDetailView(let review, let user):
                            ReviewDetailView(review: review, user: user)
                        case .orderView(let studio, let product, let totalPrice, let selectedDate):
                            OrderView(
                                studio: studio,
                                product: product,
                                totalPrice: totalPrice,
                                selectedDate: selectedDate
                            )
                        case .orderSuccessView(let studio, let product, let totalPrice, let selectedDate, let selectedOptions):
                            OrderSuccessView(
                                studio: studio,
                                product: product,
                                totalPrice: totalPrice,
                                selectedDate: selectedDate,
                                selectedOptions: selectedOptions
                            )
                        }
                    }
            }
            .environmentObject(navigationManager)
        }
    }
}
