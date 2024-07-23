//
//  UsersListRemocaoView.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 04/07/22.
//

import SwiftUI

struct UsersListRemocaoView: View {
    let viewModel: UsersListRemocaoViewModel
    var actionRemover: (Conta) -> Void
    
    @State private var action = false
    var body: some View {
        ZStack{
            NavigationLink(destination: viewModel.openDetailView(), isActive: self.$action, label: {EmptyView()})
            Button(action: {self.action = true}, label: {
                PresentationBtnView(conta: viewModel.conta, actionRemover: actionRemover)
            })
        }
    }
}

struct LUsersListRemocaoView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView(viewModel: UsersListViewModel(conta: Conta(id: 12334567, username: "rafaalt", nomeCompleto: "Rafael Assuncao", isPrivate: true, iconUrl: "", isVerified: true)))
    }
}
