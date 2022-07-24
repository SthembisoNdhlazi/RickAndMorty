//
//  ViewController.swift
//  RickAndMorty
//
//  Created by IACD-020 on 2022/07/23.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    
    var characters:[Character]?
    
    @IBOutlet var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let urlString = "https://rickandmortyapi.com/api/character"
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
            }
        }
        
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
            
    }

    func parse(json:Data){
        let decoder = JSONDecoder()
        
        if let jsonCharacters = try? decoder.decode(Characters.self, from: json){
            characters = jsonCharacters.results
            print(characters)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters?.count ?? 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        
        if let characters = characters{
            let character = characters[indexPath.row]
            cell.setUpContent(character: character)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController{
            destination.character = characters![tableView.indexPathForSelectedRow!.row]
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "details", sender: self)
    }

}

