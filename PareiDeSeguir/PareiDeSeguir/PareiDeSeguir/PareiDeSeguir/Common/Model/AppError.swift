//
//  AppError.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 07/06/22.
//

import Foundation

enum AppError: Error {
  case response(message: String)
  
  public var message: String {
    switch self {
      case .response(let message):
        return message
    }
  }
    
}
