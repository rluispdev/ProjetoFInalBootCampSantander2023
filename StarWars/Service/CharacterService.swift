//
//  CharacterService.swift
//  StarWars
//
//  Created by Rafael Gonzaga on 3/16/25.
//

import Foundation
import Alamofire

class CharacterService {
    func fetchCharacters(page: Int = 1, allCharacters: [Character] = [], completion: @escaping ([Character]) -> Void) {
        let urlString = "https://swapi.dev/api/people/?page=\(page)"
        
        AF.request(urlString).responseDecodable(of: APIResponse.self) { response in
            switch response.result {
            case .success(let result):
                let newCharacters = allCharacters + result.results
                if let next = result.next, !next.isEmpty {
                    self.fetchCharacters(page: page + 1, allCharacters: newCharacters, completion: completion)
                } else {
                    completion(newCharacters) // Retorna os personagens finalizados
                }
            case .failure(let error):
                print("Erro na requisição: \(error)")
                completion([]) // Retorna lista vazia em caso de erro
            }
        }
    }
}
