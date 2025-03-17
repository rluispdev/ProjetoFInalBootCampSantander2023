//
//  APIResponse.swift
//  StarWars
//
//  Created by Rafael Gonzaga on 3/9/25.
//

import Foundation

// Estrutura que representa a resposta da API
struct APIResponse: Decodable {
    let next: String?  // O campo "next" da API
    let results: [Character]  // Lista de personagens retornada pela API
}

