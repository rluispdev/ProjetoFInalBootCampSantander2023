//
//  DetailViewController.swift
//  StarWars
//
//  Created by Rafael Gonzaga on 3/9/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    // Propriedade para armazenar o personagem selecionado
    var character: Character?

    // UI Elements conectados ao Storyboard
    @IBOutlet weak var nameLabel: UILabel!   // Nome do personagem
    @IBOutlet weak var heightLabel: UILabel! // Altura
    @IBOutlet weak var genderLabel: UILabel! // Gênero

    override func viewDidLoad() {
          super.viewDidLoad()
          displayCharacterDetails()
      }

      func displayCharacterDetails() {
          guard let character = character else {
              print("Nenhum personagem foi passado, aqui e DetailView e nao chegou personagem aqui")
              return
          }
          print("Character: \(character.name), \(character.height), \(character.gender)")

          // Teste com dados hardcoded para garantir que as labels estão funcionando
          nameLabel.text = "Nome: \(character.name)"
          heightLabel.text = character.height.isEmpty ? "Altura: Não disponível" : "Altura: \(character.height) cm"
          genderLabel.text = character.gender.isEmpty ? "Gênero: Não disponível" : "Gênero: \(character.gender)"
      }
  }
