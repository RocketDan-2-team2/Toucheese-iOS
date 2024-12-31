//
//  NavigationManager.swift
//  Toucheese
//
//  Created by 최주리 on 12/12/24.
//

import SwiftUI

final class NavigationManager: ObservableObject {   
    @Published var selectedTab: TabViewType = .home
    
    @Published var homePath: [ViewType] = []
    @Published var reservationPath: [ViewType] = []
    
    @Published var path: [ViewType] = []
    
    @Published var fullScreenCover: FullScreenCoverType?
    @Published var alert: AlertType?
    @Published var toast: ToastType?
    
    //MARK: - View
    
    @ViewBuilder
    func build(_ view: ViewType) -> some View {
        switch view {
        case .conceptView:
            ConceptView()
        case let .studioListView(concept):
            StudioListView(concept: concept)
        case let .studioDetailView(studioId):
            StudioDetailView(studioId: studioId)
        case let .studioProductDetailView(studio, product, hoursRawData):
            StudioProductDetailView(studio: studio, product: product, hoursRawData: hoursRawData)
        case let .reviewDetailView(review, user):
            ReviewDetailView(review: review, user: user)
        case let .orderView(studio, product, totalPrice, selectedDate, user):
            OrderView(
                studio: studio,
                product: product,
                totalPrice: totalPrice,
                selectedDate: selectedDate,
                user: user
            )
        case let .orderSuccessView(studio, product, totalPrice, selectedDate, selectedOptions):
            OrderSuccessView(
                studio: studio,
                product: product,
                totalPrice: totalPrice,
                selectedDate: selectedDate,
                selectedOptions: selectedOptions
            )
            
        case .reservationListView:
            ReservationListView()
        case let .reservationDetailView(reservation):
            ReservationDetailView(reservation: reservation)
        case let .reservationUpdateView(reservation, hoursRowData, changeDate):
            ReservationUpdateView(reservation: reservation, hoursRawData: hoursRowData, changeDate: changeDate)
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
            homePath.removeLast(homePath.count)
        case .reservation:
            reservationPath.removeLast(reservationPath.count)
        }
    }
    
    //MARK: - FullScreenCover
    
    @ViewBuilder
    func build(_ fullScreenCover: FullScreenCoverType) -> some View {
        switch fullScreenCover {
        case let .filterExpansionView(studioViewModel):
            FilterExpansionView(studioViewModel: studioViewModel)
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
