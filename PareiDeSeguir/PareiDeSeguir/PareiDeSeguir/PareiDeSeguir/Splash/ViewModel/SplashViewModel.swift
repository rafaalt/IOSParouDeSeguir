//
//  SplashViewModel.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 02/06/22.
//

import Foundation
import SwiftUI

class SplashViewModel: ObservableObject{
    @Published var uiState: SplashModel = .loading
    
    func onAppear(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.uiState = .goToHome
        }
    }
}

extension SplashViewModel{
    func iniciarApp() -> some View{
        return SplashViewRouter.goToApp()
    }
}
