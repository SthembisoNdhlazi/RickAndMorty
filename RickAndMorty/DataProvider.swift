//
//  DataProvider.swift
//  RickAndMorty
//
//  Created by IACD-020 on 2022/07/26.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case parsingFailed
}

class DataProvider {
    
    var characters:[Character]?
    let urlString = "https://rickandmortyapi.com/api/character"
    
//    func parse(json:Data){
//        let decoder = JSONDecoder()
//
//        if let jsonCharacters = try? decoder.decode(Characters.self, from: json){
//            characters = jsonCharacters.results
//        }
//
//    }
    
    func fetchData(completion: @escaping(Result<Characters, NetworkError>)-> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                completion(.failure(.badURL))
                return
            }
            
            
            DispatchQueue.main.async {
                // JSONDecoder() converts data to model of type Array
                do {
                    let products = try? JSONDecoder().decode(Characters.self, from: data)
                    if let safeProducts = products {
                        completion(.success(safeProducts))
                    } else {
                        completion(.failure(.parsingFailed))
                    }
                }
                catch {
                    completion(.failure(.parsingFailed))
                }
            }
            
            
        }.resume()
    }
}
