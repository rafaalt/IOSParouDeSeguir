//
//  UserInteractor.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 07/06/22.
//

import Foundation
import Combine

class UserInteractor{
    private let remote: UserRemoteDataSource = .shared
    
    func searchUser(username: String) -> Future<UserResponse, AppError>{
        return remote.searchUser(username: username)
    }
    
    func getFollowers(id: Int64, nextId: String?) -> Future<ListUserResponse, AppError>{
        return remote.getFollowers(id: id, nextId: nextId)
    }
    
    func getFollowing(id: Int64, nextId: String?) -> Future<ListUserResponse, AppError>{
        return remote.getFollowing(id: id, nextId: nextId)
    }
}
