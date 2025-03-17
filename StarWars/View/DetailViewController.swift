//
//  DetailViewController.swift
//  StarWars
//
//  Created by Rafael Gonzaga on 3/9/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Propriedades
    
    // Propriedade para armazenar o personagem selecionado, que será passada pela ViewController principal
    var character: Character?

    // MARK: - IBOutlets (Elementos de UI conectados ao Storyboard)
    @IBOutlet weak var imageView: UIImageView! 
    @IBOutlet weak var nameLabel: UILabel!   // Nome do personagem
    @IBOutlet weak var heightLabel: UILabel! // Altura
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var skinColorLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel! // Gênero

    // MARK: - Ciclo de Vida da ViewController
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            print("viewDidLoad do DetailViewController") // Mensagem para depuração
            
            // Chama o método para exibir os detalhes do personagem
            displayCharacterDetails()
        }

        // MARK: - Métodos Auxiliares
        
        /// Exibe os detalhes do personagem na tela
        func displayCharacterDetails() {
            // Verifica se o personagem foi passado corretamente
            guard let character = character else {
                print("Nenhum personagem foi passado, aqui é DetailView e não chegou personagem aqui")
                return
            }
            
            // Exibe os detalhes no console para depuração
            print("Character: \(character.name), \(character.height), \(character.gender), \(character.birth_year), \(character.eye_color), \(character.hair_color), \(character.mass), \(character.skin_color)")

            // Atualiza as labels com as informações do personagem, incluindo tratamento para valores vazios
            nameLabel.text = "Nome: \(character.name)"
            heightLabel.text = character.height.isEmpty ? "Altura: Não disponível" : "Altura: \(character.height) cm"
            massLabel.text = character.mass.isEmpty ? "Peso: Não disponível" : "Peso: \(character.mass) kg"
            genderLabel.text = character.gender.isEmpty ? "Gênero: Não disponível" : "Gênero: \(character.gender)"
            birthYearLabel.text = character.birth_year.isEmpty ? "Ano de nascimento: Não disponível" : "Ano de nascimento: \(character.birth_year)"
            eyeColorLabel.text = character.eye_color.isEmpty ? "Cor dos olhos: Não disponível" : "Cor dos olhos: \(character.eye_color)"
            hairColorLabel.text = character.hair_color.isEmpty ? "Cor do cabelo: Não disponível" : "Cor do cabelo: \(character.hair_color)"
            skinColorLabel.text = character.skin_color.isEmpty ? "Cor da pele: Não disponível" : "Cor da pele: \(character.skin_color)"
            genderLabel.text = character.gender.isEmpty ? "Gênero: Não disponível" : "Gênero: \(character.gender)"
            
            // Define a imagem padrão para todos os personagens
            imageView.image = UIImage(named: "star_logo")
        }
    }
