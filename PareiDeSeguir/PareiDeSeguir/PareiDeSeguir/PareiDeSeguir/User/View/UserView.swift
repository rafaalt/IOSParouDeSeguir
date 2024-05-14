//
//  HomeView.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 31/05/22.
//

import SwiftUI

struct UserView: View {
    @State var username = ""
    @State var showFollowError = false
    @State var showInfoError = false
    
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        Group{
            if case UserModel.goToApp = viewModel.uiState{
                viewModel.homeView()
            }
            else if case UserModel.error(let string) = viewModel.uiState{
                ZStack{
                    mainView
                    Text("")
                        .alert(isPresented: .constant(true)){
                            Alert(title: Text("Atenção"), message: Text(string),dismissButton: .default(Text("Tentar novamente")){
                                viewModel.uiState = .normal
                            })
                        }
                }
            }
            else if case UserModel.loading = viewModel.uiState{
                ZStack(alignment: .bottom){
                    mainView
                    VStack{
                        Text(viewModel.progressInfo)
                            .foregroundColor(Color("textColor"))
                    ProgressView(value: viewModel.progressLoading)
                        .progressViewStyle(.linear)
                        .accentColor(Color("textColor"))
                    }
                }
            }
            else{
                mainView
            }
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(viewModel: UserViewModel(interactor: UserInteractor()))
    }
}
extension UserView{
    var textoUsuario: some View{
        HStack{
            Spacer()
            Image(systemName: "at")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(Color("textColor"))
                .padding(.trailing, 10)
                .accessibility(label: Text("@"))
            EditTextView(username: $username, placeholder: "Insira seu usuário")
                .frame(width: 250, height: 30)
                .accessibility(label: Text("Local para inserir o usuario"))
            Spacer()
        }
        .padding(.bottom, 30)
    }
}
extension UserView{
    var botoesAjuda: some View{
        HStack{
            Spacer()
            Button(){
                self.showInfoError = true
            }
            label: {
            Image("btnInfo")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(Color("textColor"))
                .accessibility(label: Text("Botao com Logo de Ajuda"))
            }
            .alert(isPresented: $showInfoError){
                Alert(title: Text("Ajuda"), message: Text("Para acessar o aplicativo é necessário seguir a conta \"ParouDeSeguirApp\""),dismissButton: .default(Text("Voltar")){})
            }
            Spacer()
            
            Button(){
                let url = URL(string: "http://www.instagram.com/paroudeseguirapp")!
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.openURL(url)
                }
            }
            label: {
            Image("btnInsta")
                .resizable()
                .frame(width: 150, height: 150)
                .accentColor(Color.red)
                .accessibility(label: Text("Botao com Logo do Instagram"))
            }
            Spacer()
        }
        
    }
}
extension UserView{
    var mainView: some View{
        ZStack{
            Color("backgroundColor")
            VStack{
                Spacer()
                Image("logo2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .padding(.top, 40)
                    .accessibility(label: Text("Icon Aplicativo, Parou de Seguir?"))
                Text("Insira o Usuário")
                    .foregroundColor(Color("textColor"))
                    .bold()
                    .font(.largeTitle)
                    .padding(10)
                    .accessibility(label: Text("Texto pedindo para informar o Usuario"))
                textoUsuario
                if UserModel.normal == viewModel.uiState{
                    Button("Pesquisar"){
                        if(self.username.isEmpty){
                            self.showFollowError = true
                        }
                        else{
                            viewModel.entrarApp(username: self.username, nextId: nil)
                        }
                    }.alert(isPresented: $showFollowError){
                        Alert(title: Text("Erro ao acessar os dados"), message: Text("Perfil inválido!"),dismissButton: .default(Text("OK")){})
                    }
                        .buttonStyle(.borderedProminent)
                }
                else if UserModel.loading == viewModel.uiState{
                    Button("Pesquisar"){
                        if(self.username.isEmpty){
                            self.showFollowError = true
                        }
                        else{
                            viewModel.entrarApp(username: self.username, nextId: nil)
                        }
                    }.disabled(true)
                        .buttonStyle(.borderedProminent)
                }
                Spacer()
                Spacer()
                botoesAjuda
                Spacer()
                
            }

        }
        .ignoresSafeArea()
    }
}
