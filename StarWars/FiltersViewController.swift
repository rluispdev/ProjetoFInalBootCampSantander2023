//
//  FiltersViewController.swift
//  StarWars
//
//  Created by Rafael Gonzaga on 3/9/25.
//
import UIKit

protocol FiltersViewControllerDelegate: AnyObject {
    func didChangeFilter(gender: Gender)
}
 

class FiltersViewController: UIViewController {

    var genderSegmentControl: UISegmentedControl!
    var filterButton: UIButton!
    
    var selectedGender: Gender = .all
    weak var delegate: FiltersViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
        title = "Filtrar Personagens"
        
        // Criação do UISegmentedControl programaticamente
        genderSegmentControl = UISegmentedControl(items: Gender.allCases.map { $0.rawValue.capitalized })
        genderSegmentControl.selectedSegmentIndex = Gender.allCases.firstIndex(of: selectedGender) ?? 0
        genderSegmentControl.addTarget(self, action: #selector(filterChanged(_:)), for: .valueChanged)
        
        // Botão de filtro
        filterButton = UIButton(type: .system)
        filterButton.setTitle("Aplicar Filtro", for: .normal)
        filterButton.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        
        // Adicionando o UISegmentedControl e o botão à view
        genderSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(genderSegmentControl)
        self.view.addSubview(filterButton)
        
        // Definindo as constraints para o UISegmentedControl e o botão
        NSLayoutConstraint.activate([
            genderSegmentControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            genderSegmentControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            genderSegmentControl.widthAnchor.constraint(equalToConstant: 300),
            genderSegmentControl.heightAnchor.constraint(equalToConstant: 40),
            
            filterButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            filterButton.topAnchor.constraint(equalTo: genderSegmentControl.bottomAnchor, constant: 20)
        ])
    }

    @objc func filterChanged(_ sender: UISegmentedControl) {
        let selectedGender = Gender.allCases[sender.selectedSegmentIndex]
        self.selectedGender = selectedGender
        print("Filtro alterado para: \(selectedGender.rawValue)")
    }

    @objc func applyFilter() {
        delegate?.didChangeFilter(gender: selectedGender)
        navigationController?.popViewController(animated: true)
    }
}
