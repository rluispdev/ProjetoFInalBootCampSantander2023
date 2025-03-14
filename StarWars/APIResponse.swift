//
//  APIResponse.swift
//  StarWars
//
//  Created by Rafael Gonzaga on 3/9/25.
//

import Foundation


struct APIResponse: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let height: String
    let gender: String
}

enum Gender: String, CaseIterable {
    case all = "all"
    case male = "male"
    case female = "female"
    case n_a = "n/a"
    case none = "none"
    case hermaphrodite = "hermaphrodite"
}

