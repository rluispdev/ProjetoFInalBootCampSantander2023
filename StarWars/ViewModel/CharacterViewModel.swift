//
//  CharacterViewModel.swift
//  StarWars
//
//  Created by Rafael Gonzaga on 3/16/25.
//

import Foundation
 
class CharacterViewModel {
    private var allCharacters: [Character] = [] // Todos os personagens da API
    private(set) var characters: [Character] = [] // Personagens filtrados
    private var service = CharacterService()
    var onDataUpdated: (() -> Void)? // Callback para atualizar a tela
    
    var currentFilter: Gender = .all {
        didSet {
            applyFilter() // Sempre que o filtro mudar, atualiza a lista
        }
    }
    
    func fetchData() {
        service.fetchCharacters { [weak self] characters in
            self?.allCharacters = characters
            self?.applyFilter()
        }
    }
    
    private func applyFilter() {
        if currentFilter == .all {
            characters = allCharacters
        } else {
            characters = allCharacters.filter { $0.gender.lowercased() == currentFilter.rawValue.lowercased() }
        }
        onDataUpdated?() // Notifica a ViewController para recarregar a tabela
    }
}
