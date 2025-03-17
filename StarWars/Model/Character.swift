//
//  Character.swift
//  StarWars
//
//  Created by Rafael Gonzaga on 3/16/25.
//

import Foundation

// Estrutura que representa um personagem da API
struct Character: Decodable {
    let name: String  // Nome do personagem
    let height: String  // Altura do personagem
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String  // Gênero do personagem
    
    
    
}

// Enumeração que representa os diferentes gêneros possíveis
enum Gender: String, CaseIterable {
    case all = "all"  // Todos os gêneros
    case male = "male"  // Masculino
    case female = "female"  // Feminino
    case n_a = "n/a"  // Gênero não informado
    case none = "none"  // Nenhum gênero
    case hermaphrodite = "hermaphrodite"  // Hermafrodita
}
