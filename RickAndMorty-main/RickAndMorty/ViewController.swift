//
//  ViewController.swift
//  RickAndMorty
//
//  Created by IACD-020 on 2022/07/23.
//

import UIKit




class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var dataProvider = DataProvider()
    
    
   
    
    @IBOutlet var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let urlString = "https://rickandmortyapi.com/api/character"
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                dataProvider.parse(json: data)
                
                if let charactersArray = dataProvider.characters{
                    for _ in charactersArray{
                        dataProvider.isFavourited.append(false)
                    }
                }
            }
        }
        
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
            
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataProvider.characters?.count ?? 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        
        if let characters = dataProvider.characters{
            let character = characters[indexPath.row]
            cell.setUpContent(character: character, isFavourite: dataProvider.isFavourited[indexPath.row])
            
        }
        cell.favouriteDelegate = self
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController{
            destination.character = dataProvider.characters![tableView.indexPathForSelectedRow!.row]
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "details", sender: self)
    }

}

extension ViewController:Favouritable{
    
    func toggleFavourite(for cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell){
        
        dataProvider.toggleFavourite(for: indexPath.row)
            tableView.reloadData()
        }
    }
    
   
    
    
}


