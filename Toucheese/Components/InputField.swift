//
//  InputField.swift
//  Toucheese
//
//  Created by 유지호 on 12/20/24.
//


import SwiftUI

struct InputField: View {
    let title: String
    let placeholder: String
    
    @Binding var fieldState: InputFieldState
    @Binding var inputField: String
    
    init(
        title: String = "",
        placeholder: String = "",
        fieldState: Binding<InputFieldState>,
        inputField: Binding<String>
    ) {
        self.title = title
        self.placeholder = placeholder
        self._fieldState = fieldState
        self._inputField = inputField
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 2) {
                if !title.isEmpty {
                    Text(title)
                        .font(.system(size: 14))
                        .foregroundStyle(.gray05)
                        .frame(height: 17)
                }
                
                HStack {
                    TextField(
                        "",
                        text: $inputField,
                        prompt: Text(placeholder)
                            .font(.system(size: 16))
                            .foregroundStyle(.gray05)
                    )
                    .onChange(of: inputField) {
                        fieldState = inputField.isEmpty ? .empty : .editing
                    }
                    
                    Button {
                        inputField.removeAll()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.gray05)
                            .frame(width: 20, height: 20)
                            .padding(2)
                            .opacity(inputField.isEmpty ? 0 : 1)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
            }
            .overlay(alignment: .bottom) {
                Rectangle()
                    .fill(fieldState.lineColor)
                    .frame(height: 2)
                    .offset(y: 1)
            }
            
            if !fieldState.description.isEmpty {
                Text(fieldState.description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.red)
                    .frame(height: 20)
            }
        }
    }
}
