//
//  CharacterCell.swift
//  StarWars
//
//  Created by Rafael Gonzaga on 3/9/25.
//

import UIKit

  class CharacterCell: UITableViewCell {
      @IBOutlet weak var nameLabel: UILabel! // Nome do personagem
         
         func configure(with character: Character) {
             nameLabel.text = character.name
         }
    
}
