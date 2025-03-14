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
    
    // Criação do UISegmentedControl programaticamente
    var genderSegmentControl: UISegmentedControl!
    
    weak var delegate: FiltersViewControllerDelegate?
    var selectedGender: Gender = .all

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print("FiltersViewController foi carregado.")
    }
    
    func setupUI() {
        // Definir o título da tela
        title = "Filtrar Personagens"
        
        // Criando e configurando o UISegmentedControl
        genderSegmentControl = UISegmentedControl(items: Gender.allCases.map { $0.rawValue.capitalized })
        genderSegmentControl.selectedSegmentIndex = Gender.allCases.firstIndex(of: selectedGender) ?? 0
        genderSegmentControl.addTarget(self, action: #selector(filterChanged(_:)), for: .valueChanged)
        
        // Adicionando o UISegmentedControl à view
        genderSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genderSegmentControl)
        
        // Definindo as constraints
        NSLayoutConstraint.activate([
            genderSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderSegmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            genderSegmentControl.widthAnchor.constraint(equalToConstant: 300),
            genderSegmentControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func filterChanged(_ sender: UISegmentedControl) {
        let selectedGender = Gender.allCases[sender.selectedSegmentIndex]
        print("Segmento selecionado: \(selectedGender.rawValue)")  // Verifique qual segmento foi selecionado
        
        delegate?.didChangeFilter(gender: selectedGender)  // Passa o filtro para o ViewController
        navigationController?.popViewController(animated: true)  // Fecha o filtro
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("FiltersViewController está sendo fechado.")
    }
}
