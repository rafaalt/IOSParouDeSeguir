//
//  SplashViewRouter.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 02/06/22.
//

import SwiftUI

enum SplashViewRouter{
    
    static func goToApp() -> some View{
        return UserView(viewModel: UserViewModel(interactor: UserInteractor()))
    }
}
