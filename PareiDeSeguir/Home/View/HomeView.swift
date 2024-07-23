//
//  HomeView.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 31/05/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var isSelectedCheck: Bool = false
    
    var body: some View {

        TabView{
            //Tela 1 - Perfil Usuario
            profileView
            .tabItem{Label("Profile", systemImage: "person.fill")}
            //Tela 2 - Seguidores
            Group{
            if viewModel.getSeguidores().isEmpty{
                VStack{
                Text("Seguidores")
                    .bold()
                    .foregroundColor(Color("textColor"))
                    .padding(25)
                Spacer()
                Text("Lista Vazia")
                    .bold()
                    .foregroundColor(Color("textColor"))
                    .font(.title2)
                Spacer()
                }
            }
            else{
            ListTabView(lista: viewModel.getSeguidores(), text: "Seguidores")
            }
            }
            .tabItem{Label("Seguidores", systemImage: "stop.circle.fill")}
            //Tela 3 - Seguindo
            Group{
            if viewModel.getSeguindo().isEmpty{
                VStack{
                Text("Seguindo")
                    .bold()
                    .foregroundColor(Color("textColor"))
                    .padding(25)
                Spacer()
                Text("Lista Vazia")
                    .bold()
                    .foregroundColor(Color("textColor"))
                    .font(.title2)
                Spacer()
                }
            }
            else{
            ListTabView(lista: viewModel.getSeguindo(), text: "Seguindo")
            }
            }
            .tabItem{Label("Seguindo", systemImage: "delete.backward.fill")}
            Group{
                if viewModel.getNaoSegueVolta().isEmpty{
                    VStack{
                    Text("Não segue de volta")
                        .bold()
                        .foregroundColor(Color("textColor"))
                        .padding(25)
                    Spacer()
                    Text("Lista Vazia")
                        .bold()
                        .foregroundColor(Color("textColor"))
                        .font(.title2)
                    Spacer()
                    }
                }
                else{
            //Tela 4 - Nao Segue de Volta
            ListTabWVerifiedView(lista: viewModel.getNaoSegueVolta(), text: "Não segue de volta")
                }
            }
            .tabItem{Label("Não segue de volta", systemImage: "arrowshape.turn.up.backward.2.circle.fill")}
            
            Group{
                if viewModel.getParouDeSeguir().isEmpty{
                    VStack{
                    Text("Parou de Seguir")
                        .bold()
                        .foregroundColor(Color("textColor"))
                        .padding(25)
                    Spacer()
                    Text("Lista Vazia")
                        .bold()
                        .foregroundColor(Color("textColor"))
                        .font(.title2)
                    Spacer()
                    }
                }
                else{
            //Tela 5 - Parou De Seguir
            ListTabRemocaoView(viewModel: ListRemocaoViewModel(contaPrincipal: viewModel.contaPrincipal))
                }
            }
            .tabItem{Label("Historico", systemImage: "list.dash")}
        }
}
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(conta: ContaPrincipal(nomeCompleto: "Rafael Assuncao", username: "rafaalt", id: 1698663381, biography: "BH",
                                                                       qtSeguidores: 300, qtSeguindo: 300, seguidores: [], seguindo: [], isVerified: false, isPrivate: false, iconUrl: "http://cbissn.ibict.br/index.php/imagens/1-galeria-de-imagens-01/detail/3-imagem-3-titulo-com-ate-45-caracteres", mediaCount: 1)))
    }
}

extension HomeView{
    var profileView: some View{
        VStack{
            Text("Bem-Vindo,")
                .bold()
                .font(.title)
                .foregroundColor(Color("textColor"))
                .padding(.top, 100)
            Text("\(viewModel.getUsername())!")
                .bold()
                .font(.title)
                .foregroundColor(Color("textColor"))
            ImageView(url: viewModel.getUrl())
                .frame(width: 250, height: 250)
                .cornerRadius(15.0)
                .accessibility(label: Text("Foto de Perfil"))
            Text("@\(viewModel.getUsername())")
                .bold()
                .font(.title2)
                .foregroundColor(Color("textColor"))
            Text(viewModel.getNomeCompleto())
                .font(.title3)
                .foregroundColor(Color("textColor"))
            
            Text(viewModel.getBiography())
                .frame(width: 200)
                    .foregroundColor(Color("textColor"))
                    .background(Color("backgroundColor2"))
                    .border(Color.gray, width: 0.2)
                    .accessibility(label: Text("Biografia"))
            Spacer()
            HStack{
                Text("Seguidores: \(viewModel.getQtSeguidores())")
                .bold()
                .foregroundColor(Color("textColor"))
                Text("Seguindo: \(viewModel.getQtSeguindo())")
                .bold()
                .foregroundColor(Color("textColor"))
            }
            HStack{
                Spacer()
                Spacer()
                privateView
                Spacer()
                verifiedView
                Spacer()
                Spacer()
            }
            Spacer()
        }
    }
}
extension HomeView{
    var verifiedView: some View{
        Group{
        if case viewModel.getVerified() = true{
            VStack{
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .foregroundColor(Color("textColor"))
                .frame(width: 50, height: 50)
                .background(Color.white)
                .cornerRadius(4.0)
                .accessibility(label: Text("Imagem indicando perfil verificado"))
            }
        }
        else{
            VStack{
            Image("null")
                .frame(width: 50, height: 50)
                .background(Color.white)
                .cornerRadius(4.0)
                .accessibility(label: Text("Perfil nao verificado"))

        }
        }
    }
}
    var privateView: some View{
        Group{
        if case viewModel.getPrivate() = true{
            VStack{
            Image(systemName: "lock.square.fill")
                .foregroundColor(Color("textColor"))
                .frame(width: 50, height: 50)
                .background(Color.white)
                .cornerRadius(4.0)
                .accessibility(label: Text("Imagem indicando perfil privado"))
            }
        }
        else{
            VStack{
            Image("null")
                .frame(width: 50, height: 50)
                .background(Color.white)
                .cornerRadius(4.0)
                .accessibility(label: Text("Perfil publico"))
        }
        }
    }
}
}
