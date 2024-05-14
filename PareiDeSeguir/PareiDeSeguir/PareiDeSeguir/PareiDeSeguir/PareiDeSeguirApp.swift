//
//  PareiDeSeguirApp.swift
//  PareiDeSeguir
//
//  Created by coltec on 31/05/22.
//

import SwiftUI

@main
struct PareiDeSeguirApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel())
        }
    }
}
