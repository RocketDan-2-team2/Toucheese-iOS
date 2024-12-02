//
//  StudioProductDetailView.swift
//  Toucheese
//
//  Created by 유지호 on 11/29/24.
//

import SwiftUI

struct StudioProductDetailView: View {
    @State private var product: StudioProduct
    @State private var selectedDate: Date = .now
    
    var totalPrice: Int {
        product.optionList.reduce(product.price) {
            $0 + $1.price * $1.count
        }
    }
    
    init(product: StudioProduct) {
        self.product = product
        self.selectedDate = selectedDate
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack {
                    AsyncImage(url: URL(string: product.image ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 140, height: 200)
                    .background(.placeholder)
                    
                    Text(product.name)
                        .font(.title)
                        .fontWeight(.medium)
                    
                    Text(product.description)
                        .font(.footnote)
                }
                .frame(maxWidth: .infinity)
                
                HStack {
                    Text("가 격")
                        .font(.title3)
                        .bold()
                    
                    Spacer()
                    
                    Text(product.price.formatted() + "원")
                        .bold()
                }
                
                Divider()
                
                if !product.optionList.isEmpty {
                    VStack(alignment: .leading) {
                        Text("추가 옵션")
                            .font(.headline)
                            .bold()
                        
                        ForEach($product.optionList) { $option in
                            AdditionalProductOptionCell(option: $option)
                        }
                    }
                    
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("희망 날짜")
                        .font(.headline)
                        .bold()
                    
                    HStack {
                        Text(selectedDate.formatted())
                        
                        Spacer()
                        
                        Button("날짜 선택") {
                            
                        }
                        .buttonStyle(.borderedProminent)
                        .foregroundStyle(.primary)
                        .clipShape(.capsule)
                        .tint(.yellow)
                    }
                }
                
                Button {
                    
                } label: {
                    Capsule()
                        .fill(.yellow)
                        .frame(height: 40)
                        .overlay {
                            Text("주문하기 (₩\(totalPrice))")
                        }
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 36)
        }
    }
}

#Preview {
    StudioProductDetailView(product: .mockData[0])
}
