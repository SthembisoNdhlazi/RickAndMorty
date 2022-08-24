//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by IACD-020 on 2022/07/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var characterImage: UIImageView!
    
    var character:Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        speciesLabel.text = character?.species
        nameLabel.text = character?.name
        statusLabel.text = character?.status
        characterImage.downloaded(from: character?.image ?? "")
        
        
    }
    

 

}


