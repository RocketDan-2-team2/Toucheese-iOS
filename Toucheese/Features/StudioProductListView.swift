//
//  StudioProductListView.swift
//  Toucheese
//
//  Created by 유지호 on 11/27/24.
//

import SwiftUI
import Combine

struct StudioProductListView: View {
    let studioService: StudioService = MockStudioService()
    
    @State private var productList: [StudioProduct] = StudioProduct.mockData
    @State private var selectedProduct: StudioProduct?
    @State private var bag = Set<AnyCancellable>()
    
    var body: some View {
        ScrollView {
            StudioNoticeView(notice: "저희 공운스튜디오는 주차장을 따로 운영하고 있습니다! 스튜디오 건물 오른 편으로 돌아 골목에 주차 가능합니다")
                .padding(.horizontal)
            
            LazyVStack(alignment: .leading) {
                Text("촬영 상품")
                    .font(.headline)
                    .padding(.horizontal)
                
                ForEach(productList) { product in
                    Button {
                        studioService.getStudioProductDetail(productID: product.id)
                            .sink { event in
                                switch event {
                                case .finished:
                                    print("ProductDetail: \(event)")
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            } receiveValue: { product in
                                selectedProduct = product.translate()
                            }
                            .store(in: &bag)
                    } label: {
                        StudioProductCell(product: product)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.vertical, 8)
        }
        .navigationDestination(item: $selectedProduct) { product in
            StudioProductDetailView(product: product)
        }
    }
}

#Preview {
    NavigationStack {
        StudioProductListView()
    }
}
