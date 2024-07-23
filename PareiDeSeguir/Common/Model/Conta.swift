//
//  Conta.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 02/06/22.
//

import Foundation

class Conta: Identifiable, Equatable{
    var id: Int64
    var username: String
    var nomeCompleto: String
    var isPrivate: Bool
    var iconUrl: String
    var isVerified: Bool
    
    init(id: Int64, username: String, nomeCompleto: String,
         isPrivate: Bool, iconUrl: String, isVerified: Bool){
        self.id = id
        self.username = username
        self.nomeCompleto = nomeCompleto
        self.isPrivate = isPrivate
        self.iconUrl = iconUrl
        self.isVerified = isVerified
    }
    
    static func == (lhs: Conta, rhs: Conta) -> Bool{
        return (lhs.id == rhs.id || lhs.username == rhs.username)
    }
    
    func containText(text: String) -> Bool{
        return self.username.contains(text)
    }
    
}

class ContaPrincipal: Identifiable{
    var id: Int64
    var username: String
    var nomeCompleto: String
    var biography: String
    var seguidores: [Conta]
    var seguindo: [Conta]
    var isPrivate: Bool
    var iconUrl: String
    var isVerified: Bool
    var mediaCount: Int
    var qtSeguidores: Int
    var qtSeguindo: Int
    
    var naoSegueVolta: [Conta]
    var seguidoresAntigo: [Conta]
    var parouDeSeguir: [Conta]

    init(){
        self.nomeCompleto = "ALOOU"
        self.username = "alou"
        self.id = 0
        self.qtSeguindo = 0
        self.qtSeguidores = 0
        self.seguindo = []
        self.seguidores = []
        self.isVerified = false
        self.isPrivate = false
        self.mediaCount = 0
        self.iconUrl = ""
        self.biography = ""
        self.parouDeSeguir = []
        self.naoSegueVolta = []
        self.seguidoresAntigo = []
        }
    
    init(nomeCompleto: String, username: String, id: Int64, biography: String, qtSeguidores: Int, qtSeguindo: Int, seguidores: [Conta], seguindo: [Conta], isVerified: Bool, isPrivate: Bool, iconUrl: String, mediaCount: Int){

        self.nomeCompleto = nomeCompleto
        self.username = username
        self.id = id
        self.qtSeguindo = qtSeguindo
        self.qtSeguidores = qtSeguidores
        self.seguindo = []
        self.seguidores = []
        self.isVerified = isVerified
        self.isPrivate = isPrivate
        self.mediaCount = mediaCount
        self.iconUrl = iconUrl
        self.biography = biography
        self.parouDeSeguir = []
        self.naoSegueVolta = []
        self.seguidoresAntigo = []
        verificaNaoSegueDeVolta()
        verificaParouDeSeguir()
        
    }//init
    
    func verificaNaoSegueDeVolta(){
        for follow in self.seguindo{
            if self.seguidores.contains(follow){
                
            }
            else{
                self.naoSegueVolta.append(follow)
            }
        }
    }
    
    func adicionarSeguidor(conta: Conta){
        if(!self.seguidores.contains(conta)){
            self.seguidores.append(conta)
        }
    }
    
    func adicionarSeguindo(conta: Conta){
        if(!self.seguindo.contains(conta)){
            self.seguindo.append(conta)
        }
    }
    
    func verificaParouDeSeguir(){
        for follow in self.seguidoresAntigo{
            if self.seguidores.contains(follow){
                
            }
            else{
                if(!self.parouDeSeguir.contains(follow)){
                    self.parouDeSeguir.append(follow)
                }

            }
        }
    }
    
    func fazerVerificacoes(){
        self.verificaParouDeSeguir()
        self.verificaNaoSegueDeVolta()
    }
    
    func porcentagemAtual() -> Double{
        let total = Double(qtSeguindo + qtSeguidores)
        let atual = Double(self.seguindo.count + self.seguidores.count)
        let retorno = atual/total
        return retorno
    }
    
    func porcentagemAtualString() -> String{
        let total = Double(qtSeguindo + qtSeguidores)
        let atual = Double(self.seguindo.count + self.seguidores.count)
        var retorno = atual/total
        retorno = retorno*100.0
        let ret: String = String(format: "%.2f", retorno)
        return ret
    }
    func porcentagemSeguidoresAtuais() -> String{
        let ret = "(\(self.seguidores.count)/\(self.qtSeguidores)"
        return ret
    }
    func porcentagemSeguindoAtuais() -> String{
        let ret = "(\(self.seguindo.count)/\(self.qtSeguindo)"
        return ret
    }
    
    func verificaSeguidoresTotais() -> Bool{
        return self.qtSeguidores <= self.seguidores.count
    }

    func verificaSeguindoTotais() -> Bool{
        return self.qtSeguindo <= self.seguindo.count
    }
    
    func removerParou(conta: Conta){
        parouDeSeguir = parouDeSeguir.filter { $0 != conta }
    }
    func adicionarSeguidorParou(conta: Conta){
        self.parouDeSeguir.append(conta)
    }
}

