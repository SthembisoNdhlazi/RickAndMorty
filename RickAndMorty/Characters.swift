//
//  Characters.swift
//  RickAndMorty
//
//  Created by IACD-020 on 2022/07/23.
//

import Foundation




struct Character:Codable{
    var name:String
    var status:String
    var species:String
    var image:String
    

}

struct Characters:Codable{
    var results:[Character]
}


