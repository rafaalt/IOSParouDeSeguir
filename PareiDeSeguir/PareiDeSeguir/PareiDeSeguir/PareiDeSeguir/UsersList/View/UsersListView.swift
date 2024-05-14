//
//  ListaUsuariosView.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 06/06/22.
//

import SwiftUI

struct UsersListView: View {
    let viewModel: UsersListViewModel
    
    @State private var action = false
    var body: some View {
        ZStack{
            NavigationLink(destination: viewModel.openDetailView(), isActive: self.$action, label: {EmptyView()})
            Button(action: {self.action = true}, label: {
                PresentationView(conta: viewModel.conta)
            })
        }
    }
}

struct LUsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView(viewModel: UsersListViewModel(conta: Conta(id: 12334567, username: "rafaalt", nomeCompleto: "Rafael Assuncao", isPrivate: true, iconUrl: "https://instagram.fkiv1-1.fna.fbcdn.net/v/t51.2885-19/147115823_933519634144286_1535032367782607406_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fkiv1-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=ZX4I48ejZIIAX86I7Lq&edm=AEF8tYYBAAAA&ccb=7-5&oh=00_AT8M0xBCC4rIo7oBP9JIV3uPNtY9hF-8FeU-KBU42FlXeg&oe=62A03F39&_nc_sid=a9513d", isVerified: true)))
    }
}
