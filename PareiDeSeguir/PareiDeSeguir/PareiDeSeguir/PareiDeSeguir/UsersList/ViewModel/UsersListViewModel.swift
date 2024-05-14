//
//  UsersListViewModel.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 06/06/22.
//

import Foundation
import SwiftUI

struct UsersListViewModel{
    var conta: Conta
    
    func openDetailView() -> some View{
        return UsersListViewRouter.makeDetailView(conta: conta, contaUser: nil)
    }
}
