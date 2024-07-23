//
//  SplashView.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 31/05/22.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group{
            switch viewModel.uiState{
            case .loading:
                ZStack{
                    Color("backgroundColor")
                    Image("logo3")
                        .resizable()
                        .scaledToFit()
                        .padding(30)
                        
                }.accessibility(label: Text("Tela inicial com logo do aplicativo, Parou de Seguir? Sem senha"))
                
            case .goToHome:
                viewModel.iniciarApp()
            }
        }.onAppear(perform: {
            viewModel.onAppear()
        })

        }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(viewModel: SplashViewModel())
    }
}
