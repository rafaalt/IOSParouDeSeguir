//
//  ListUserResponse.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 07/06/22.
//

import Foundation

struct UserBasic: Decodable{
    var id: Int64
    var username: String
    var nomeCompleto: String
    var isPrivate: Bool
    var iconUrl: String
    var isVerified: Bool
    
    enum CodingKeys: String, CodingKey{
        case id = "pk"
        case username
        case nomeCompleto = "full_name"
        case isPrivate = "is_private"
        case iconUrl = "profile_pic_url"
        case isVerified = "is_verified"
    }
    
}


struct ListUserResponse: Decodable{
    
    let users: [UserBasic]
    let proximoId: String?
    let bigList: Bool
    
    enum CodingKeys: String, CodingKey{
        case users
        case proximoId = "next_max_id"
        case bigList = "big_list"
    }
    
}
