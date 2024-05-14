//
//  UserViewRouter.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 02/06/22.
//

import Foundation
import SwiftUI

enum UserViewRouter{
    

    static func goToHomeView(conta: ContaPrincipal) -> some View{
    
        return HomeView(viewModel: HomeViewModel(conta: conta))
    }
}
