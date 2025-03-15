//
//  ViewController.swift
//  StarWars
//
//  Created by Rafael Gonzaga on 3/8/25.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
        
    // MARK: - Propriedades
       
       var allCharacters: [Character] = []  // Armazena todos os personagens baixados da API
       var characteres: [Character] = []    // Lista de personagens filtrados a serem exibidos na tabela
       var currentFilter: Gender = .all     // Filtro de gênero atual (padrão: "todos")
       
       // MARK: - Ciclo de Vida da View
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           // Configura o botão de filtro na barra de navegação
           navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filtrar", style: .plain, target: self, action: #selector(showFilters))
           
           // Define a origem dos dados e as ações da tabela
           tableView.dataSource = self
           tableView.delegate = self
           
           // Busca os personagens ao carregar a tela
           fetchData()
       }
       
       // MARK: - Métodos de UI
       
       // Exibe a tela de filtros quando o botão for pressionado
       @objc func showFilters() {
           let filtersVC = FiltersViewController()
           filtersVC.delegate = self
           filtersVC.selectedGender = currentFilter
           navigationController?.pushViewController(filtersVC, animated: true)
       }
       
       // MARK: - Requisição de Dados
       
       /// Busca os personagens da API SWAPI com suporte à paginação
       /// - Parameters:
       ///   - page: Número da página atual na API
       ///   - allCharacters: Lista acumulada de personagens já baixados
    func fetchData(page: Int = 1, allCharacters: [Character] = []) {
        let urlString = "https://swapi.dev/api/people/?page=\(page)"
        
        AF.request(urlString).responseDecodable(of: APIResponse.self) { response in
            switch response.result {
            case .success(let result): // `result` já é do tipo APIResponse
                let newCharacters = allCharacters + result.results
                
                // Verifica se há mais páginas a serem carregadas
                if let next = result.next, !next.isEmpty {
                    self.fetchData(page: page + 1, allCharacters: newCharacters)
                } else {
                    // Se todos os personagens foram baixados, armazena e aplica filtro
                    self.allCharacters = newCharacters
                    self.applyFilter()
                }
                
            case .failure(let error):
                print("Erro na requisição: \(error)")
            }
        }
    }
       
       // MARK: - Filtragem de Dados
       
       /// Aplica o filtro de gênero na lista de personagens
       func applyFilter() {
           if currentFilter == .all {
               characteres = allCharacters  // Se for "todos", exibe toda a lista
           } else {
               characteres = allCharacters.filter { $0.gender.lowercased() == currentFilter.rawValue.lowercased() }
           }
           
           // Atualiza a tabela na thread principal
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
       }
       
       // MARK: - UITableViewDataSource
       
       /// Retorna o número de células que serão exibidas na tabela
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return characteres.count
       }
       
       /// Configura cada célula da tabela com o nome do personagem
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
           let character = characteres[indexPath.row]
           cell.textLabel?.text = character.name
           return cell
       }
       
       // MARK: - Navegação
       
       /// Detecta a seleção de uma célula na tabela e aciona a navegação para a tela de detalhes
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let selectedCharacter = characteres[indexPath.row]
           performSegue(withIdentifier: "showDetail", sender: selectedCharacter)
       }
       
       /// Prepara os dados antes da navegação para a tela de detalhes
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showDetail",
              let detailVC = segue.destination as? DetailViewController,
              let selectedCharacter = sender as? Character {
               detailVC.character = selectedCharacter
           }
       }
       
       // MARK: - FiltersViewControllerDelegate
       
       /// Atualiza o filtro ao retornar da tela de filtros
       func didChangeFilter(gender: Gender) {
           self.currentFilter = gender
           applyFilter()  // Aplica o filtro sem fazer nova requisição
       }
   }
