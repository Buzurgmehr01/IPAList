//
//  NetworkService.swift
//  IPAList
//
//  Created by Temp on 07/02/23.
//

import Foundation

class NetworkService {
    
    let urlString = "https://itunes.apple.com/search?term=jack+johnson&limit=5"

    
    func request(url: String,  complition: @escaping (Result<SearchResponse, Error>) -> Void){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error{
                    print("Some error")
//                    complition(nil, error)
                    complition(.failure(error))
                    return
                }
                
                guard let data = data else { return }
//                let dataString = String(data: data, encoding: .utf8)
//                print(dataString ?? "no data"){
                
                do{
                    let track = try JSONDecoder().decode(SearchResponse.self, from: data)
//                    complition(track, nil)
                    complition(.success(track))

                }catch{
                    print("eror")
//                    complition(nil, error)
                    complition(.failure(error))
                }
            }
        }.resume()
    }
}
