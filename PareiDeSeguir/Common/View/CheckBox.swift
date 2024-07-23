//
//  CheckBox.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 13/06/22.

import SwiftUI
import Foundation

struct CheckBox: View {
    
    @Binding var isSelected: Bool
    
    var body: some View {
        Group{
            if case isSelected = true{
            Button {
                self.isSelected = false
            }label: {
                Image(systemName: "square.inset.filled")
                    .resizable()
                    .foregroundColor(Color("textColor"))
                    .frame(width: 18, height: 18)
                }
            }
            else{
                Button {
                    self.isSelected = true
                }label: {
                    Image(systemName: "square")
                        .resizable()
                        .foregroundColor(Color("textColor"))
                        .frame(width: 18, height: 18)
                    }
                }
            }
        }
    
    func getSelection() -> Bool{
        return self.isSelected
    }
    }
