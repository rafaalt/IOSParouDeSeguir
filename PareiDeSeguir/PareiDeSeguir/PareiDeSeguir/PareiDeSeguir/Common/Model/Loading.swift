//
//  Loading.swift
//  PareiDeSeguir
//
//  Created by coltec on 14/06/22.
//

import Foundation

class Loading{
    var porcentagemPorCemSegd: Double
    var porcentagemPorCemSegu: Double
    var porcentagemAtual: Double
    var seguidoresTotais: Int
    var seguindoTotais: Int
    
    init(seguidores: Int, seguindo: Int){
        self.seguindoTotais = seguindo
        self.seguidoresTotais = seguidores
        self.porcentagemPorCemSegd = (Double) (seguidoresTotais/4200)
        self.porcentagemPorCemSegu = (Double) (seguindoTotais/4200)
        self.porcentagemAtual = 0.08
    }
    
    func chegouMetade(){
        self.porcentagemAtual = 0.5
    }
    
    func addSeguidores(){
        self.porcentagemAtual += porcentagemPorCemSegd
    }
    
    func addSeguindo(){
        self.porcentagemAtual += porcentagemPorCemSegu
    }
}
