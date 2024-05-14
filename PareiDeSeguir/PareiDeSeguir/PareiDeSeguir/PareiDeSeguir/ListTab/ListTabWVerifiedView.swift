//
//  ListTabWVerifiedView.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 13/06/22.
//

import SwiftUI

struct ListTabWVerifiedView: View {
    private let lista: [Conta]
    private let text: String
    @State var isSelected: Bool = false
    
    init(lista: [Conta], text: String){
        self.lista = lista
        self.text = text
    }
    
    var body: some View {
        VStack{
            NavigationView{
                VStack{
                    HStack{
                        Spacer()
                        Text("Ignorar verificados")
                        CheckBox(isSelected: $isSelected)
                            .padding(.trailing, 30)
                            .accessibility(label: Text("CheckBox Para Eliminar Verificados"))
                    }
                    HStack{
                        Text("\(text)")
                        .bold()
                        .foregroundColor(Color("textColor"))
                        .font(.title2)
                    }
                    List(lista){value in
                        if(!(isSelected && value.isVerified)){
                            UsersListView(viewModel: UsersListViewModel(conta: value))
                        }
                }
                }
            }.navigationTitle(text)
    }
}
}

struct ListTabWVerifiedView_Previews: PreviewProvider {
    static var previews: some View {
        ListTabWVerifiedView(lista: [], text: "Lista")
    }
}
