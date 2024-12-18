//
//  NavigationManager.swift
//  Toucheese
//
//  Created by 최주리 on 12/12/24.
//

import SwiftUI

final class NavigationManager: ObservableObject {
    var selectedTab: TabViewType = .home
    
    @Published var homePath: [ViewType] = []
    @Published var reservationPath: [ViewType] = []
    
    @Published var fullScreenCover: FullScreenCoverType?
    
    //MARK: - View
    
    @ViewBuilder
    func build(_ view: ViewType) -> some View {
        switch view {
        case let .conceptView(conceptList):
            ConceptView(conceptList: conceptList)
        case let .studioListView(concept):
            StudioListView(concept: concept)
        case let .studioDetailView(studioId):
            StudioDetailView(studioId: studioId)
        case let .studioProductDetailView(studio, product, hoursRawData):
            StudioProductDetailView(studio: studio, product: product, hoursRawData: hoursRawData)
        case let .reviewDetailView(review, user):
            ReviewDetailView(review: review, user: user)
        case let .orderView(studio, product, totalPrice, selectedDate):
            OrderView(
                studio: studio,
                product: product,
                totalPrice: totalPrice,
                selectedDate: selectedDate
            )
        case let .orderSuccessView(studio, product, totalPrice, selectedDate, selectedOptions):
            OrderSuccessView(
                studio: studio,
                product: product,
                totalPrice: totalPrice,
                selectedDate: selectedDate,
                selectedOptions: selectedOptions
            )
        }
    }
    
    func push(_ view: ViewType) {
        switch selectedTab {
        case .home:
            homePath.append(view)
        case .reservation:
            reservationPath.append(view)
        }
    }
    
    func pop(_ depth: Int) {
        switch selectedTab {
        case .home:
            homePath.removeLast(depth)
        case .reservation:
            reservationPath.removeLast(depth)
        }
    }
    
    func popToRoot() {
        switch selectedTab {
        case .home:
            homePath.removeLast(homePath.count - 1)
        case .reservation:
            reservationPath.removeLast(reservationPath.count)
        }
    }
    
    //MARK: - FullScreenCover
    
    @ViewBuilder
    func build(_ fullScreenCover: FullScreenCoverType) -> some View {
        switch fullScreenCover {
        case let .reviewPhotoDetailView(imageList, selectedPhotoIndex):
            ReviewPhotoDetailView(imageList: imageList, selectedPhotoIndex: selectedPhotoIndex)
        }
    }
    
    func present(fullScreenCover: FullScreenCoverType) {
        self.fullScreenCover = fullScreenCover
    }
    
    func dismiss() {
        fullScreenCover = nil
    }
    
}
