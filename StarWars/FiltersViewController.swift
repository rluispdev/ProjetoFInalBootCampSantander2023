
//  FiltersViewController.swift
//  StarWars
//
//  Created by Rafael Gonzaga on 3/9/25.
//

import UIKit

protocol FiltersViewControllerDelegate: AnyObject {
    func didChangeFilter(gender: Gender)
}

class FiltersViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var genderPickerView: UIPickerView!
    var filterButton: UIButton!
    var titleLabel: UILabel!
    
    var selectedGender: Gender = .all
    weak var delegate: FiltersViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.black // Fundo escuro para um efeito futurista

        // Título estilizado
        titleLabel = UILabel()
        titleLabel.text = "Escolha um Filtro"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Criando UIPickerView
        genderPickerView = UIPickerView()
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        genderPickerView.backgroundColor = UIColor.darkGray
        genderPickerView.layer.cornerRadius = 10
        genderPickerView.layer.masksToBounds = true
        genderPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Seleciona o gênero atual como default no Picker
        if let index = Gender.allCases.firstIndex(of: selectedGender) {
            genderPickerView.selectRow(index, inComponent: 0, animated: false)
        }
        
        // Botão de filtro estilizado
        filterButton = UIButton(type: .system)
        filterButton.setTitle("Aplicar Filtro", for: .normal)
        filterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        filterButton.setTitleColor(.white, for: .normal)
        filterButton.backgroundColor = UIColor.systemBlue
        filterButton.layer.cornerRadius = 10
        filterButton.layer.shadowColor = UIColor.white.cgColor
        filterButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        filterButton.layer.shadowOpacity = 0.7
        filterButton.layer.shadowRadius = 4
        filterButton.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Adicionando os elementos à view
        self.view.addSubview(titleLabel)
        self.view.addSubview(genderPickerView)
        self.view.addSubview(filterButton)
        
        // Definindo as constraints para um layout harmônico
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            genderPickerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            genderPickerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            genderPickerView.widthAnchor.constraint(equalToConstant: 300),
            genderPickerView.heightAnchor.constraint(equalToConstant: 150),
            
            filterButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            filterButton.topAnchor.constraint(equalTo: genderPickerView.bottomAnchor, constant: 40),
            filterButton.widthAnchor.constraint(equalToConstant: 200),
            filterButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Gender.allCases.count
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Gender.allCases[row].rawValue.capitalized
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGender = Gender.allCases[row]
        print("Filtro alterado para: \(selectedGender.rawValue)")
    }

    // Aplicar filtro
    @objc func applyFilter() {
        delegate?.didChangeFilter(gender: selectedGender)
        navigationController?.popViewController(animated: true)
    }
}
