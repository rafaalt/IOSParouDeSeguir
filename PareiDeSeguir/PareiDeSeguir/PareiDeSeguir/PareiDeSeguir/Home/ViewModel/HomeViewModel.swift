//
//  HomeViewModel.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 02/06/22.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var contaPrincipal: ContaPrincipal
    //1698663381 rafaalt
    
    init(conta: ContaPrincipal){
//        let conta2 = ContaPrincipal(nomeCompleto: "Rafael Assuncao", username: "rafaalt", id: 1698663381, biography: "BH",
//                                    qtSeguidores: 300, qtSeguindo: 300, seguidores: [], seguindo: [], isVerified: false, isPrivate: false, iconUrl: "", mediaCount: 1)
        self.contaPrincipal = conta
    }
    public func getId() -> Int64{
        return contaPrincipal.id
    }
    
    public func getSeguidores() -> [Conta]{
        return contaPrincipal.seguidores
    }
    
    public func getSeguindo() -> [Conta]{
        return contaPrincipal.seguindo
    }
    public func getQtSeguindo() -> Int{
        return contaPrincipal.qtSeguindo
    }

    public func getQtSeguidores() -> Int{
        return contaPrincipal.qtSeguidores
    }
    
    public func getNomeCompleto() -> String{
        return contaPrincipal.nomeCompleto
    }
    
    public func getBiography() -> String{
        return contaPrincipal.biography
    }
    
    public func getUsername() -> String{
        return contaPrincipal.username
    }
    
    public func getVerified() -> Bool{
        return contaPrincipal.isVerified
    }
    
    public func getPrivate() -> Bool{
        return contaPrincipal.isPrivate
    }
    
    public func getMediaCount() -> Int{
        return contaPrincipal.mediaCount
    }
    
    public func getUrl() -> String{
        return contaPrincipal.iconUrl
    }
    
    public func getNaoSegueVolta() -> [Conta]{
        return contaPrincipal.naoSegueVolta
    }
    
    public func getParouDeSeguir() -> [Conta]{
        return contaPrincipal.parouDeSeguir
    }
    
    public func getSeguidoresAntigos() -> [Conta]{
        return contaPrincipal.seguidoresAntigo
    }
    
    
}
