//
//  ListTabRemocaoView.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 04/07/22.
//

import SwiftUI

struct ListTabRemocaoView: View {
    
    @ObservedObject var viewModel: ListRemocaoViewModel
    @State var mudou = false
    
    var body: some View {
        ZStack{
        VStack{
            NavigationView{
                VStack{
                    Text("Parou de Seguir")
                        .foregroundColor(Color("textColor"))
                        .bold()
                        .font(.title3)
                    if(!mudou){
                    List(viewModel.contaPrincipal.parouDeSeguir){value in
                        UsersListRemocaoView(viewModel: UsersListRemocaoViewModel(conta: value), actionRemover: {conta in
                            viewModel.removerParou(conta: conta)
                            mudou = true
                        })
                    }
                    }
                    if(mudou){
                        List(viewModel.contaPrincipal.parouDeSeguir){value in
                            UsersListRemocaoView(viewModel: UsersListRemocaoViewModel(conta: value), actionRemover: {conta in
                                viewModel.removerParou(conta: conta)
                                mudou = false
                            })
                        }
                    }
                }
            }.navigationBarTitle(Text("Parou de Seguir"))
            .ignoresSafeArea()
        }
    }
    }
}
