//
//  DataProvider.swift
//  RickAndMorty
//
//  Created by IACD-020 on 2022/07/26.
//

import Foundation

class DataProvider{
    
    
    var characters:[Character]?
    let urlString = "https://rickandmortyapi.com/api/character"
    var isFavourited = [Bool]()
    
func parse(json:Data){
    let decoder = JSONDecoder()
    
    if let jsonCharacters = try? decoder.decode(Characters.self, from: json){
        characters = jsonCharacters.results
        
      
    }
}
    
    
    func toggleFavourite(for index:Int){
        
        print("\(characters![index].name) toggled")
        
        isFavourited[index].toggle()
    }
    
}
