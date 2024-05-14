//
//  WebService.swift
//  PareiDeSeguir
//
//  Created by rafaalt on 07/06/22.
//

import Foundation
enum WebService{
    
    enum Result{
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    public static func call(username: String, completion: @escaping (Result) -> Void){
        
        let headers = [
            "X-RapidAPI-Host": "instagram-scraper-2022.p.rapidapi.com",
            "X-RapidAPI-Key": "2295348d0fmshd44c2731982934ap1fd835jsnabb4c3092fec"
        ]
        var stringRequest = "https://instagram-scraper-2022.p.rapidapi.com/ig/info_username/?user=\(username)"
        let request = NSMutableURLRequest(url: NSURL(string: stringRequest)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest){
            data, response, error in
            
            guard let data = data, error == nil else{
                completion(.failure(.badRequest, nil))
                return
            }
            if let httpResponse = response as? HTTPURLResponse{
                print(httpResponse.statusCode)
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(data))
                    break
                case 429:
                    sleep(2)
                    call(username: username, completion: completion)
                    break
                default:
                    print("Erro desconhecido: \(httpResponse.statusCode)")
                    break
                }
    
    //          print(httpResponse)

            }
        }
        dataTask.resume()
}

    public static func getList(id: Int64, tipo: String, nextId: String?, completion: @escaping (Result) -> Void){
        let headers = [
            "X-RapidAPI-Host": "instagram-scraper-2022.p.rapidapi.com",
            "X-RapidAPI-Key": "2295348d0fmshd44c2731982934ap1fd835jsnabb4c3092fec"
        ]
        //print(id)
        var stringRequest = "https://instagram-scraper-2022.p.rapidapi.com/ig/\(tipo)/?id_user=\(id)"
        
        if let proxId = nextId{
            stringRequest = "https://instagram-scraper-2022.p.rapidapi.com/ig/\(tipo)/?id_user=\(id)&next_max_id=\(proxId)"
        }
        
        print(stringRequest)
        let request = NSMutableURLRequest(url: NSURL(string: stringRequest)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest){ data, response, error in
            guard let data = data, error == nil else{
                completion(.failure(.badRequest, nil))
                return
            }
            if let httpResponse = response as? HTTPURLResponse{
                print("Status Code:\(httpResponse.statusCode)")
    
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(data))
                    break
                case 429:
                    sleep(2)
                    getList(id: id, tipo: tipo, nextId: nextId, completion: completion)
                    break
                default:
                    print("Erro desconhecido: \(httpResponse.statusCode)")
                    break
                }
            }
        }
        dataTask.resume()
    }
}
