//
//  UsersListRemocaoViewModel.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 05/07/22.
//

import Foundation
import SwiftUI

struct UsersListRemocaoViewModel{
    var conta: Conta
    
    func openDetailView() -> some View{
        return UsersListViewRouter.makeDetailView(conta: conta, contaUser: nil)
    }
    
}
