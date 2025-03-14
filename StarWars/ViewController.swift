//
//  ViewController.swift
//  StarWars
//
//  Created by Rafael Gonzaga on 3/8/25.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
   
    var characteres: [Character] = []
        var currentFilter: Gender = .all // Armazena o filtro atual

        override func viewDidLoad() {
            super.viewDidLoad()

            print("ViewController carregado.")

            tableView.dataSource = self
            tableView.delegate = self

            fetchData()
        }

    func fetchData(gender: Gender = .all) {
        print("Iniciando fetch dos dados com filtro: \(gender.rawValue)")

        var urlString = "https://swapi.dev/api/people/"

        AF.request(urlString).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Sucesso na requisição.")

                let decoder = JSONDecoder()

                if let data = try? JSONSerialization.data(withJSONObject: value, options: []) {
                    do {
                        let result = try decoder.decode(APIResponse.self, from: data)
                        var characters = result.results
                        
                        // Filtrar os personagens de acordo com o gênero selecionado
                        if gender != .all {
                            characters = characters.filter { $0.gender.lowercased() == gender.rawValue.lowercased() }
                            print("Filtrando personagens por gênero: \(gender.rawValue), resultados: \(characters.count) personagens.")
                        }
                        
                        self.characteres = characters
                        print("Dados carregados: \(self.characteres.count) personagens.")

                        // Atualiza a tabela na thread principal
                        DispatchQueue.main.async {
                            print("Número de personagens após filtro: \(self.characteres.count)")
                            self.tableView.reloadData()
                        }
                    } catch {
                        print("Erro ao decodificar os dados: \(error)")
                    }
                }

            case .failure(let error):
                print("Erro na requisição: \(error)")
            }
        }
    }

        // MARK: - UITableViewDataSource

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print("Número de linhas na tabela: \(characteres.count)")
            return characteres.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
            let character = characteres[indexPath.row]
            cell.textLabel?.text = character.name
            return cell
        }

        // MARK: - Navegação

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showFilters" {
                if let filtersVC = segue.destination as? FiltersViewController {
                    filtersVC.delegate = self
                    filtersVC.selectedGender = currentFilter // Passa o filtro atual para a tela de filtros
                    print("Abrindo FiltersViewController com filtro: \(currentFilter.rawValue)")
                }
            } else if segue.identifier == "showDetail" {
                if let character = sender as? Character {
                    if let detailVC = segue.destination as? DetailViewController {
                        detailVC.character = character
                        print("Abrindo detalhes do personagem: \(character.name)")
                    }
                }
            }
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedCharacter = characteres[indexPath.row]
            performSegue(withIdentifier: "showDetail", sender: selectedCharacter)
        }

        // MARK: - FiltersViewControllerDelegate

    func didChangeFilter( gender: Gender) {
        self.currentFilter = gender
        fetchData() // Refaz a busca com o filtro atual

        // Log para verificar se a filtragem está funcionando
        print("Filtro alterado para: \(gender.rawValue)")
        print("Número de personagens após filtragem: \(self.characteres.count)")
        
        DispatchQueue.main.async {
            self.tableView.reloadData()  // Recarrega a tabela
        }
    }
    }
