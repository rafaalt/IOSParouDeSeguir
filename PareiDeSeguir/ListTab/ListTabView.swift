//
//  ListTabView.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 13/06/22.
//

import SwiftUI

struct ListTabView: View {
    private let lista: [Conta]
    private let text: String
    private var listaSearch: [Conta]
    
    @State private var searchText = ""
    
    init(lista: [Conta], text: String){
        self.lista = lista
        self.text = text
        self.listaSearch = lista
    }
    
    var body: some View {
        ZStack{
        VStack{
            NavigationView{
                VStack{
                    Text("\(text)")
                        .foregroundColor(Color("textColor"))
                        .bold()
                        .font(.title3)
                    List(searchResults){value in
                            UsersListView(viewModel: UsersListViewModel(conta: value))
                    }
                    .searchable(text: $searchText){
                    }.accessibility(label: Text("Espaço para buscar usuario na lista"))
                    .refreshable {
                    }
                }
            }.navigationBarTitle(Text("\(text) - \(lista.count)"))
            .ignoresSafeArea()
        }
    }
    }
    
    var searchResults: [Conta]{
        if searchText.isEmpty{
            return lista
        }
        else{
            return lista.filter {
                $0.username.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

struct ListTabView_Previews: PreviewProvider {
    static var previews: some View {
        ListTabView(lista: [], text: "Lista")
    }
}
