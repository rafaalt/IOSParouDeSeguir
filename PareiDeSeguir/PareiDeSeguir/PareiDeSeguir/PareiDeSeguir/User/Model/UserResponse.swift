//
//  UserResponse.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 07/06/22.
//

import Foundation


struct User: Decodable{
    var id: Int64
    var username: String
    var nomeCompleto: String
    var biography: String
    var isPrivate: Bool
    var iconUrl: String
    var isVerified: Bool
    var mediaCount: Int
    var qtSeguidores: Int
    var qtSeguindo: Int
    
    enum CodingKeys: String, CodingKey{
        case id = "pk"
        case username
        case nomeCompleto = "full_name"
        case isPrivate = "is_private"
        case iconUrl = "profile_pic_url"
        case isVerified = "is_verified"
        case mediaCount = "media_count"
        case qtSeguidores = "follower_count"
        case qtSeguindo = "following_count"
        case biography
    }
    
}


struct UserResponse: Decodable{
    
    let user: User
    
    enum CodingKeys: String, CodingKey{
        case user
    }
    
}
