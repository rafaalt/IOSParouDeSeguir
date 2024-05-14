//
//  ListRemocaViewModel.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 05/07/22.
//

import Foundation

class ListRemocaoViewModel: ObservableObject {
    
    @Published var contaPrincipal: ContaPrincipal
    private var db: DBHelper
    
    init(contaPrincipal: ContaPrincipal){
        self.contaPrincipal = contaPrincipal
        self.db = DBHelper()
    }
    
    public func removerParou(conta: Conta){
        self.contaPrincipal.removerParou(conta: conta)
        //self.contaPrincipal.adicionarSeguidorParou(conta: conta)
        self.db.removerUserParou(conta: conta, username: contaPrincipal.username)
        
    }

}
    //1698663381 rafaalt
