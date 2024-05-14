//
//  UserRemoteDataSource.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 07/06/22.
//

import Foundation
import Combine

class UserRemoteDataSource{
    static var shared: UserRemoteDataSource = UserRemoteDataSource()
    
    private init(){}
    
    func searchUser(username: String) -> Future<UserResponse, AppError>{
        return Future<UserResponse, AppError> { promise in
            WebService.call(username: username) { result in
                switch result{
                case .failure(_, let _):
                    promise(.failure(AppError.response(message: "Erro SearchUser")))
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(UserResponse.self, from: data)
                    
                    guard let response = response else{
                        promise(.failure(AppError.response(message: "Erro SearchUser: Tente novamente")))
                        return
                    }
                    
                    promise(.success(response))
                    break
                }
            }
        }
    }
    
    func getFollowers(id: Int64, nextId: String?) -> Future<ListUserResponse, AppError>{
        return Future<ListUserResponse, AppError> { promise in
            WebService.getList(id: id, tipo: "followers", nextId: nextId) { result in
                switch result{
                case .failure(_, let _):
                    promise(.failure(AppError.response(message: "Erro SearchUser")))
                    break
                case .success(let data):
                    print("Data: \(data)!")
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(ListUserResponse.self, from: data)
                    print("Response:\(response)")
                    
                    guard let response = response else{
                        promise(.failure(AppError.response(message: "Erro Followers: Tente novamente")))
                        return
                    }
                    
                    promise(.success(response))
                    break
                }
            }
        }
    }
    
    func getFollowing(id: Int64, nextId: String?) -> Future<ListUserResponse, AppError>{
        return Future<ListUserResponse, AppError> { promise in
            WebService.getList(id: id, tipo: "following", nextId: nextId) { result in
                switch result{
                case .failure(_, let _):
                    promise(.failure(AppError.response(message: "Erro SearchUser")))
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(ListUserResponse.self, from: data)
                    
                    guard let response = response else{
                        promise(.failure(AppError.response(message: "Erro Following: Tente novamente")))
                        return
                    }
                    
                    promise(.success(response))
                    break
                }
            }
        }
    }
}


