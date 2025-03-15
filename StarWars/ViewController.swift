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
        
//        var characteres: [Character] = []
//        var currentFilter: Gender = .all
//        
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            
//            // Adicionando um botão de filtro à barra de navegação
//            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filtrar", style: .plain, target: self, action: #selector(showFilters))
//            
//            print("ViewController carregado.")
//            
//            tableView.dataSource = self
//            tableView.delegate = self
//            
//            fetchData()  // Carregar os dados sem filtro inicialmente
//        }
//        
//        // Função para exibir a tela de filtros
//        @objc func showFilters() {
//            let filtersVC = FiltersViewController()
//            filtersVC.delegate = self
//            filtersVC.selectedGender = currentFilter
//            navigationController?.pushViewController(filtersVC, animated: true)
//        }
//        
//    func fetchData(gender: Gender = .all, page: Int = 1, allCharacters: [Character] = []) {
//        print("Buscando personagens na página \(page)...")
//
//        let urlString = "https://swapi.dev/api/people/?page=\(page)"  // Adiciona paginação
//
//        AF.request(urlString).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let decoder = JSONDecoder()
//
//                if let data = try? JSONSerialization.data(withJSONObject: value, options: []) {
//                    do {
//                        let result = try decoder.decode(APIResponse.self, from: data)
//                        let newCharacters = allCharacters + result.results
//
//                        // Se houver próxima página, continua a busca
//                        if let next = (value as? [String: Any])?["next"] as? String, !next.isEmpty {
//                            self.fetchData(gender: gender, page: page + 1, allCharacters: newCharacters)
//                        } else {
//                            // Aplica o filtro de gênero após carregar todos os personagens
//                            var finalCharacters = newCharacters
//                            if gender != .all {
//                                finalCharacters = finalCharacters.filter { $0.gender.lowercased() == gender.rawValue.lowercased() }
//                            }
//                            
//                            self.characteres = finalCharacters
//                            print("Total de personagens carregados: \(self.characteres.count)")
//
//                            DispatchQueue.main.async {
//                                self.tableView.reloadData()
//                            }
//                        }
//                    } catch {
//                        print("Erro ao decodificar os dados: \(error)")
//                    }
//                }
//
//            case .failure(let error):
//                print("Erro na requisição: \(error)")
//            }
//        }
//    }
//
//        // MARK: - UITableViewDataSource
//        
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            print("Número de linhas na tabela: \(characteres.count)")
//            return characteres.count
//        }
//        
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
//            let character = characteres[indexPath.row]
//            cell.textLabel?.text = character.name
//            return cell
//        }
//        
//        // MARK: - Navegação
//        
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let selectedCharacter = characteres[indexPath.row]
//            performSegue(withIdentifier: "showDetail", sender: selectedCharacter)
//        }
//        
//        // MARK: - Prepare segue
//        
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "showDetail" {
//                if let detailVC = segue.destination as? DetailViewController {
//                    if let selectedCharacter = sender as? Character {
//                        print("Passando personagem para DetailView: \(selectedCharacter.name)")
//                        detailVC.character = selectedCharacter
//                    }
//                }
//            }
//        }
//        
//        // MARK: - FiltersViewControllerDelegate
//        
//        func didChangeFilter(gender: Gender) {
//            self.currentFilter = gender
//            fetchData(gender: gender)
//            
//            DispatchQueue.main.async {
//                self.tableView.reloadData()  // Recarrega a tabela
//            }
//        }
//    }
//
    
       var allCharacters: [Character] = []  // Todos os personagens baixados
       var characteres: [Character] = []    // Lista filtrada exibida na tabela
       var currentFilter: Gender = .all
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filtrar", style: .plain, target: self, action: #selector(showFilters))
           
           tableView.dataSource = self
           tableView.delegate = self
           
           fetchData()  // Baixar os personagens apenas uma vez
       }
       
       @objc func showFilters() {
           let filtersVC = FiltersViewController()
           filtersVC.delegate = self
           filtersVC.selectedGender = currentFilter
           navigationController?.pushViewController(filtersVC, animated: true)
       }
       
       func fetchData(page: Int = 1, allCharacters: [Character] = []) {
           let urlString = "https://swapi.dev/api/people/?page=\(page)"
           
           AF.request(urlString).responseJSON { response in
               switch response.result {
               case .success(let value):
                   let decoder = JSONDecoder()
                   
                   if let data = try? JSONSerialization.data(withJSONObject: value, options: []) {
                       do {
                           let result = try decoder.decode(APIResponse.self, from: data)
                           let newCharacters = allCharacters + result.results
                           
                           if let next = (value as? [String: Any])?["next"] as? String, !next.isEmpty {
                               self.fetchData(page: page + 1, allCharacters: newCharacters)
                           } else {
                               self.allCharacters = newCharacters
                               self.applyFilter()  // Aplica o filtro atual (inicialmente "todos")
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
       
       // Aplica o filtro sem fazer nova requisição
       func applyFilter() {
           if currentFilter == .all {
               characteres = allCharacters
           } else {
               characteres = allCharacters.filter { $0.gender.lowercased() == currentFilter.rawValue.lowercased() }
           }
           
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
       }
       
       // MARK: - UITableViewDataSource
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return characteres.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
           let character = characteres[indexPath.row]
           cell.textLabel?.text = character.name
           return cell
       }
       
       // MARK: - Navegação
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let selectedCharacter = characteres[indexPath.row]
           performSegue(withIdentifier: "showDetail", sender: selectedCharacter)
       }
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showDetail",
              let detailVC = segue.destination as? DetailViewController,
              let selectedCharacter = sender as? Character {
               detailVC.character = selectedCharacter
           }
       }
       
       // MARK: - FiltersViewControllerDelegate
       
       func didChangeFilter(gender: Gender) {
           self.currentFilter = gender
           applyFilter()  // Filtra localmente sem nova requisição
       }
   }
