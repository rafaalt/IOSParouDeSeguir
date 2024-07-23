//
//  UserModel.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 02/06/22.
//

import Foundation

enum UserModel: Equatable{
    case loading
    case normal
    case goToApp
    case error(String)
}
