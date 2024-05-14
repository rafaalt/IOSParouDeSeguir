//
//  NetworkError.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 27/06/22.
//

import Foundation

enum NetworkError : Equatable{
    case badRequest
    case notFound
    case unauthorized
    case internalServerError
    case excesso
}
