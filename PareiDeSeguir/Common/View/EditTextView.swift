//
//  EditTextView.swift
//  PareiDeSeguir
//  Created by rafaalt on 31/05/22.
//
import SwiftUI

struct EditTextView: View{
    @Binding var username: String
    var placeholder: String
    
    var body: some View{
        VStack{
            TextField(placeholder, text: $username)
                .foregroundColor(Color("textColor"))
                .textFieldStyle(CustomTextFieldStyle())
                .autocapitalization(.none)
        }
        .padding(.bottom, 1)
    }
}

struct EditTextView_Previews: PreviewProvider{
    static var previews: some View{
        ForEach(ColorScheme.allCases, id: \.self){value in
            EditTextView(username: .constant(""), placeholder: "AAA")
                .preferredColorScheme(value)
        }
    }
}
