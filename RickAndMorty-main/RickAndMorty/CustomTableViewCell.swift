//
//  CustomTableViewCell.swift
//  RickAndMorty
//
//  Created by IACD-020 on 2022/07/24.
//

import UIKit

protocol Favouritable{
    func toggleFavourite(for cell:UITableViewCell)
    
}
class CustomTableViewCell: UITableViewCell {
    
   
  
    var favouriteDelegate:Favouritable?
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var characterImg: UIImageView!
    @IBOutlet var nickName: UILabel!

    
    @IBOutlet weak var favButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favTapped(_ sender: Any) {
        favouriteDelegate?.toggleFavourite(for: self)
    }
    func setUpContent(character:Character, isFavourite:Bool){
        nameLabel.text = character.name
        nickName.text = character.species
        characterImg.downloaded(from: character.image)
        
        if isFavourite{
        favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
       
    }
    
    

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
