//
//  UsersListViewRouter.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 06/06/22.
//

import Foundation
import SwiftUI

enum UsersListViewRouter{
    static func makeDetailView(conta: Conta, contaUser: ContaPrincipal?) -> some View{
        return UserDetailView(conta: conta, contaUser: contaUser)
    }
}
