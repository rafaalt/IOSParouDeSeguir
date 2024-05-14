//
//  PresentationView.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 02/06/22.
//

import SwiftUI

struct PresentationView: View {
    var conta: Conta
    
    var body: some View {
        ZStack{
        HStack{
            ImageView(url: conta.iconUrl)
                .frame(width: 70, height: 70)
                .padding(.leading, 20)
                .cornerRadius(2.0)
                .accessibility(label: Text("Foto Perfil \(conta.username)"))
            VStack(alignment: .leading){
                HStack{
                Text(conta.username)
                    .bold()
                    .foregroundColor(Color("textColor"))
                    .font(.title2)
                    .accessibility(label: Text("Username: \(conta.username)"))
                if(conta.isVerified){
                Image("verificado")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .accessibility(label: Text("Perfil verificado"))
                    }
                }
                Text(conta.nomeCompleto)
                    .foregroundColor(Color("textColor"))
                    .accessibility(label: Text("Nome Completo: \(conta.nomeCompleto)"))
            }
            Spacer()
        }
        }
        .frame(height: 80)
        //.border(Color("textColor"), width: 1)
        //.cornerRadius(4.0)
    }
}

struct PresentationView_Previews: PreviewProvider {
    static var previews: some View {
        PresentationView(conta: Conta(id: 1, username: "rafaalt", nomeCompleto: "Rafael", isPrivate: true, iconUrl: "https://a.espncdn.com/i/teamlogos/soccer/500/2022.png", isVerified: true))
    }
}
