//
//  UserViewModel.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 02/06/22.
//

import Foundation
import SwiftUI
import Combine
import SQLite3

class UserViewModel: ObservableObject{
    @Published var uiState: UserModel = .normal
    @Published var progressLoading: Double = 0
    @Published var progressInfo: String = ""
    
    private var db: DBHelper
    
    private var seguidoresParou: [Conta]
    private var contaUser: ContaPrincipal
    private var cancellableMain: AnyCancellable?
    private var cancellableFollowers: AnyCancellable?
    private var cancellableFollowing: AnyCancellable?
    private var cancellableParou: AnyCancellable?
    
    private var totalBusca: Int
    
    private var interactor: UserInteractor
    
    init(interactor: UserInteractor){
        self.interactor = interactor
        self.contaUser = ContaPrincipal()
        self.seguidoresParou = []
        db = DBHelper()
        self.totalBusca = 0;
    }
    
    deinit {
        cancellableFollowers?.cancel()
        cancellableMain?.cancel()
        cancellableFollowing?.cancel()
        cancellableParou?.cancel()
    }
    func entrarApp(username: String, nextId: String?){
        self.uiState = .loading
        self.progressLoading = 0.0
        self.progressInfo = "Verificando..."
        if username == "paroudeseguirapp"{
            self.entrarNoApp(username: username)
        }
        else{
        cancellableParou = interactor.getFollowers(id: 53791096359, nextId: nextId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
                switch completion{
                case .failure(let error):
                        self.uiState = .error("Desculpe o transtorno\nErro na execução do aplicativo")
                    break
                case .finished:
                    break
                }
            }, receiveValue: {
                response in
                //Chegou Aqui!
                for x in response.users{
                    self.adicionarSeguidorParou(conta: Conta(id: x.id, username: x.username, nomeCompleto: x.nomeCompleto, isPrivate: x.isPrivate, iconUrl: x.iconUrl, isVerified: x.isVerified))
                }
                
                if(response.bigList){
                    self.entrarApp(username: username, nextId: response.proximoId)
                }
                else{
                    let comparacao = Conta(id: 0, username: username, nomeCompleto: "", isPrivate: false, iconUrl: "", isVerified: false)
                    if(self.seguidoresParou.contains(comparacao)){
                        self.entrarNoApp(username: username)
                    }
                    else{
                        self.uiState = .error("Essa conta não segue o perfil ParouDeSeguirApp")
                    }
                }
            })
        }
    }
    
    func entrarNoApp(username: String){
        sleep(2)
        self.progressInfo = "Carregando Perfil..."
        cancellableMain = interactor.searchUser(username: username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
                switch completion{
                    case .failure(let error):
                        self.uiState = .error("Erro na busca do Usuário\n")
                    break
                    case .finished:
                    break
                }
            }, receiveValue: {
                response in
                //Chegou Aqui!
                print(response.user.username)
                let conta = ContaPrincipal(nomeCompleto: response.user.nomeCompleto, username: response.user.username, id: response.user.id, biography: response.user.biography, qtSeguidores: response.user.qtSeguidores, qtSeguindo: response.user.qtSeguindo, seguidores: [], seguindo: [], isVerified: response.user.isVerified, isPrivate: response.user.isPrivate, iconUrl: response.user.iconUrl, mediaCount: response.user.mediaCount)
                self.trocarConta(conta: conta)
                //self.uiState = .goToApp
                //sleep(1)
                if(conta.isPrivate){
                    self.uiState = .error("Perfil privado\nImpossível realizar a busca")
                }
                else{
                self.getFollowers(id: response.user.id, nextId: nil)
                }
            })
    }
    
    func getFollowers(id: Int64, nextId: String?){
        totalBusca += 1;
        if(totalBusca < 100){
        self.progressInfo = "Carregando Seguidores... \(self.contaUser.porcentagemSeguidoresAtuais()))"
        self.progressLoading = self.contaUser.porcentagemAtual()
        if(contaUser.verificaSeguidoresTotais()){
            self.getFollowing(id: id, nextId: nil)
        }
        else{
        cancellableFollowers = interactor.getFollowers(id: id, nextId: nextId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
                switch completion{
                case .failure(let error):
                        self.uiState = .error("Erro na busca dos seguidores")
                    break
                case .finished:
                    break
                }
            }, receiveValue: {
                response in
                //Chegou Aqui!
                for x in response.users{
                    self.contaUser.adicionarSeguidor(conta: Conta(id: x.id, username: x.username, nomeCompleto: x.nomeCompleto, isPrivate: x.isPrivate, iconUrl: x.iconUrl, isVerified: x.isVerified))
                }
                
                if(response.bigList){
                    //sleep(1)
                    self.getFollowers(id: id, nextId: response.proximoId)
                }
                else{
                    self.getFollowers(id: id, nextId: nil)
                }
            })
        }
        }
        else{
            self.uiState = .error("Erro na busca do Perfil.")
        }
    }
    
    func getFollowing(id: Int64, nextId: String?){
        totalBusca += 1;
        if(totalBusca < 150){
        self.progressInfo = "Carregando Seguindo... \(self.contaUser.porcentagemSeguindoAtuais()))"
        self.progressLoading = self.contaUser.porcentagemAtual()
        if(contaUser.verificaSeguindoTotais()){
            self.progressInfo = "Finalizando... \(self.contaUser.porcentagemAtualString())%"
            self.buscaBancoDeDados()
        }
        else{
        cancellableFollowing = interactor.getFollowing(id: id, nextId: nextId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
                switch completion{
                    case .failure(let error):
                        self.uiState = .error("Erro na busca dos seguindo do perfil")
                    break
                    case .finished:
                    break
                }
            }, receiveValue: {
                response in
                //Chegou Aqui!
                for x in response.users{
                    self.contaUser.adicionarSeguindo(conta: Conta(id: x.id, username: x.username, nomeCompleto: x.nomeCompleto, isPrivate: x.isPrivate, iconUrl: x.iconUrl, isVerified: x.isVerified))
                }
                if(response.bigList){
                    //sleep(1)
                    self.getFollowing(id: id, nextId: response.proximoId)
                }
                else{
                    self.getFollowing(id: id, nextId: nil)
                }
            })
        }
    }
    else{
        self.uiState = .error("Erro na busca do Perfil.")
    }
    }
    
    func buscaBancoDeDados(){
        let username = contaUser.username
        //Seguidores Antigos com banco de dados
        self.db.createTableSeguidores(username: username)
        
        self.contaUser.seguidoresAntigo = db.lerSeguidores(table: username)
        
        self.db.deleteTable(table: username)
        self.db.createTableSeguidores(username: username)
        for follower in contaUser.seguidores{
            self.db.inserirSeguidor(table: username, conta: follower)
        }
        //Parou de seguir com banco de dados
        self.db.createTableParou(username: username)
        self.contaUser.parouDeSeguir = db.lerParou(table: username)
        self.contaUser.fazerVerificacoes()
        for parou in contaUser.parouDeSeguir{
            self.db.inserirSeguidorParou(table: username, conta: parou)
        }
        //Encerra 
        self.uiState = .goToApp
    }
    
    func homeView() -> some View{
        return UserViewRouter.goToHomeView(conta: contaUser)
    }
    
    func trocarConta(conta: ContaPrincipal){
        self.contaUser = conta
    }
    func adicionarSeguidorParou(conta: Conta){
        if(!seguidoresParou.contains(conta)){
            self.seguidoresParou.append(conta)
        }
    }
}
