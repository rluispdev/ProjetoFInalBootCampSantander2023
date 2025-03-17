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
    private var viewModel = CharacterViewModel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filtrar", style: .plain, target: self, action: #selector(showFilters))
            
            tableView.dataSource = self
            tableView.delegate = self
            
            viewModel.onDataUpdated = { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            
            viewModel.fetchData()
        }
        
        @objc func showFilters() {
            let filtersVC = FiltersViewController()
            filtersVC.delegate = self
            filtersVC.selectedGender = viewModel.currentFilter
            navigationController?.pushViewController(filtersVC, animated: true)
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.characters.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
            cell.textLabel?.text = viewModel.characters[indexPath.row].name
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedCharacter = viewModel.characters[indexPath.row]
            performSegue(withIdentifier: "showDetail", sender: selectedCharacter)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDetail",
               let detailVC = segue.destination as? DetailViewController,
               let selectedCharacter = sender as? Character {
                detailVC.character = selectedCharacter
            }
        }
        
        func didChangeFilter(gender: Gender) {
            viewModel.currentFilter = gender
        }
    
    
    
    }
