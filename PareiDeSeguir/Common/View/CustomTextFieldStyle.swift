//
//  CustomTextFieldStyle.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 31/05/22.
//

import SwiftUI
struct CustomTextFieldStyle: TextFieldStyle{
    
    public func _body(configuration: TextField<Self._Label>) -> some View{
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(Color.cyan, lineWidth: 0.8)
            )
    }
}
