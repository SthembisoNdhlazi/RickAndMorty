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
        
        dataProvider.fetchData { result in
            switch result {
            case .success(let characters):
                self.dataProvider.characters = characters.results
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
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
            cell.setUpContent(character: character)
            
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.character = dataProvider.characters![tableView.indexPathForSelectedRow!.row]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "details", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}



