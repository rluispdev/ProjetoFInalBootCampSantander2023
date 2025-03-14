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
    var currentFilter: Gender = .all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adicionando um botão de filtro à barra de navegação
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filtrar", style: .plain, target: self, action: #selector(showFilters))
        
        print("ViewController carregado.")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchData()  // Carregar os dados sem filtro inicialmente
    }

    // Função para exibir a tela de filtros
    @objc func showFilters() {
        let filtersVC = FiltersViewController()
        filtersVC.delegate = self
        filtersVC.selectedGender = currentFilter
        navigationController?.pushViewController(filtersVC, animated: true)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = characteres[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: selectedCharacter)
    }

    // MARK: - FiltersViewControllerDelegate

    func didChangeFilter(gender: Gender) {
        self.currentFilter = gender
        fetchData(gender: gender)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()  // Recarrega a tabela
        }
    }
}
